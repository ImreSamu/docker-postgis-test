#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

matrix_file="matrix.yml"
runner_platforms_json="${RUNNER_PLATFORMS_JSON:-}"
output_file="${GITHUB_OUTPUT:-}"

set_output() {
  local line="$1"
  if [[ -n "$output_file" ]]; then
    echo "$line" >> "$output_file"
  else
    echo "$line"
  fi
}

if [[ ! -f "$matrix_file" ]]; then
  echo "ERROR: $matrix_file not found in repo root" >&2
  exit 1
fi

if [[ -z "$runner_platforms_json" ]]; then
  echo "ERROR: RUNNER_PLATFORMS_JSON is required" >&2
  exit 1
fi

echo "Using $(yq --version)"

# Read build_targets from matrix.yml and convert to compact JSON.
# Supports both mikefarah/yq (v4, with `eval`) and python-yq (jq wrapper).
if build_targets="$(yq eval '.build_targets' "$matrix_file" -o=json -I=0 2>/dev/null)"; then
  :
else
  build_targets="$(yq '.build_targets' "$matrix_file" | jq -c '.')"
fi
set_output "BUILD_TARGETS=$build_targets"

# Expand build_targets × runner platforms
runner_platforms="$(jq -c '.' <<< "$runner_platforms_json")"
build_include="$(jq -c --argjson platforms "$runner_platforms" '
  [ .[] as $combo | $platforms[] | $combo + {"runner-platform": .} ]
' <<< "$build_targets")"
set_output "BUILD_INCLUDE=$build_include"

echo "Loaded BUILD_TARGETS with $(jq 'length' <<< "$build_targets") entries"
echo "Expanded BUILD_INCLUDE with $(jq 'length' <<< "$build_include") entries"

echo "Validating ./$matrix_file..."

# 1. Check build_targets exists and is not empty
build_count="$(jq 'length' <<< "$build_targets")"
if [[ "$build_count" -eq 0 ]]; then
  echo "ERROR: matrix.yml has no build_targets" >&2
  exit 1
fi

# 2. Check required non-empty fields: postgres, postgis, variant, tags
invalid_entries="$(jq -c '
  [ .[] | select(
      .postgres == null or .postgres == "" or
      .postgis == null or .postgis == "" or
      .variant == null or .variant == "" or
      .tags == null or .tags == ""
    )]
' <<< "$build_targets")"

if [[ "$(jq 'length' <<< "$invalid_entries")" -gt 0 ]]; then
  echo "ERROR: Some entries have missing or empty required fields (postgres/postgis/variant/tags):" >&2
  jq '.' <<< "$invalid_entries" >&2
  exit 1
fi

# 3. Verify exactly one entry has 'latest' tag
latest_count="$(jq '
  [ .[] | select(.tags | tostring | test("(^| )latest( |$)")) ] | length
' <<< "$build_targets")"
if [[ "$latest_count" -ne 1 ]]; then
  echo "ERROR: Expected exactly 1 entry with 'latest' tag, found: $latest_count" >&2
  jq -r '.[] | select(.tags | tostring | test("(^| )latest( |$)"))' <<< "$build_targets" >&2
  exit 1
fi

echo "[OK] matrix.yml valid: $build_count targets, all have required fields, 1 'latest' tag"
