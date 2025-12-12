#!/usr/bin/env bash
set -euo pipefail

repo="${1:-}"
tags="${2:-}"
digests_dir="${3:-.}"

if [[ -z "$repo" || -z "$tags" ]]; then
  echo "Usage: ci/push-manifest.sh <dockerhub-repo> <tags> [digests-dir]" >&2
  exit 2
fi

cd "$digests_dir"

shopt -s nullglob
digests=( * )
shopt -u nullglob
if [[ "${#digests[@]}" -eq 0 ]]; then
  echo "ERROR: No digest files found in $digests_dir" >&2
  exit 1
fi

tag_args=""
for tag in $tags; do
  tag_args+=" -t ${repo}:${tag}"
done

echo "Creating multi-arch manifest with tags:${tag_args}"

# shellcheck disable=SC2046,SC2086
docker buildx imagetools create $tag_args \
  $(printf "${repo}@sha256:%s " "${digests[@]}")

echo "[OK] Manifest created and pushed"
