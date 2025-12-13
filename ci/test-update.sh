#!/usr/bin/env bash
set -Eeuo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

pass_count=0
fail_count=0

fail() {
  echo "[FAIL] $*" >&2
  fail_count=$((fail_count + 1))
}

pass() {
  echo "[OK] $*"
  pass_count=$((pass_count + 1))
}

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg="${3:-}"
  if [[ "$expected" != "$actual" ]]; then
    fail "${msg} expected='${expected}' actual='${actual}'"
    return 1
  fi
}

assert_contains_word() {
  local haystack="$1"
  local needle="$2"
  local msg="${3:-}"
  if ! grep -Eq "(^|[[:space:]])${needle}($|[[:space:]])" <<<"$haystack"; then
    fail "${msg} missing word '${needle}' in: ${haystack}"
    return 1
  fi
}

assert_not_contains_word() {
  local haystack="$1"
  local needle="$2"
  local msg="${3:-}"
  if grep -Eq "(^|[[:space:]])${needle}($|[[:space:]])" <<<"$haystack"; then
    fail "${msg} unexpected word '${needle}' in: ${haystack}"
    return 1
  fi
}

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

# Load functions without executing main.
# shellcheck disable=SC1091
source ./update.sh

test_build_tags_latest_and_alpine() {
  local tags
  local old_latest="$LATEST_VERSION"
  LATEST_VERSION="18-3.6"

  tags="$(build_tags "18" "3.6" "default" "trixie" "3.6.1")"
  assert_contains_word "$tags" "18-3.6" "default tags" || return 1
  assert_contains_word "$tags" "18-3.6-trixie" "default tags" || return 1
  assert_contains_word "$tags" "18-3.6.1-trixie" "default patch tag" || return 1
  assert_contains_word "$tags" "latest" "default latest tag" || return 1
  pass "build_tags: default stable adds latest"

  tags="$(build_tags "18" "3.6" "alpine" "alpine3.22" "3.6.1")"
  assert_contains_word "$tags" "18-3.6-alpine" "alpine tags" || return 1
  assert_contains_word "$tags" "18-3.6-alpine3.22" "alpine tags" || return 1
  assert_contains_word "$tags" "18-3.6.1-alpine3.22" "alpine patch tag" || return 1
  assert_contains_word "$tags" "alpine" "alpine special tag" || return 1
  assert_not_contains_word "$tags" "latest" "alpine should not add latest" || return 1
  pass "build_tags: alpine stable adds alpine (not latest)"

  LATEST_VERSION="$old_latest"
}

test_build_tags_prerelease() {
  local tags
  local old_latest="$LATEST_VERSION"
  LATEST_VERSION="18-3.6"

  tags="$(build_tags "18" "3.6" "default" "trixie" "3.6.0beta1")"
  assert_contains_word "$tags" "18-3.6.0beta1-trixie" "prerelease patch tag" || return 1
  assert_not_contains_word "$tags" "latest" "prerelease must not add latest" || return 1
  pass "build_tags: prerelease gets patch tag, no latest"

  tags="$(build_tags "18" "3.6" "alpine" "alpine3.22" "3.6.0beta1")"
  assert_contains_word "$tags" "18-3.6.0beta1-alpine3.22" "prerelease alpine patch tag" || return 1
  assert_not_contains_word "$tags" "alpine" "prerelease must not add alpine special tag" || return 1
  pass "build_tags: prerelease alpine gets patch tag, no alpine special tag"

  LATEST_VERSION="$old_latest"
}

test_detect_optimized_bucket() {
  assert_eq "test"   "$(detect_optimized_bucket "17-master" "default")" "bucket for master" || return 1
  assert_eq "alpine" "$(detect_optimized_bucket "17-3.5" "alpine")" "bucket for alpine" || return 1
  assert_eq "debian" "$(detect_optimized_bucket "17-3.5" "default")" "bucket for default" || return 1
  pass "detect_optimized_bucket"
}

test_build_tags_realworld_prerelease_examples() {
  local tags
  local old_latest="$LATEST_VERSION"
  LATEST_VERSION="99-99"

  # Example: "17-3.6.0beta1-alpine"
  tags="$(build_tags "17" "3.6.0beta1" "alpine" "alpine3.22" "3.6.0beta1")"
  assert_contains_word "$tags" "17-3.6.0beta1-alpine" "combo tag for alpine prerelease" || return 1
  assert_contains_word "$tags" "17-3.6.0beta1-alpine3.22" "os tag for alpine prerelease" || return 1
  assert_not_contains_word "$tags" "alpine" "no special alpine tag for prerelease" || return 1
  pass "build_tags: prerelease PostGIS in combo (alpine)"

  # Example: "17beta3-master" (postgres prerelease + postgis master)
  tags="$(build_tags "17beta3" "master" "default" "bullseye" "development")"
  assert_contains_word "$tags" "17beta3-master" "combo tag for postgres prerelease + master" || return 1
  assert_contains_word "$tags" "17beta3-master-bullseye" "os tag for postgres prerelease + master" || return 1
  pass "build_tags: postgres prerelease + postgis master"

  LATEST_VERSION="$old_latest"
}

test_render_template() {
  local template="$tmpdir/tpl"
  local out="$tmpdir/out"

  cat >"$template" <<'EOF'
A=%%A%%
B=%%B%%
EOF

  render_template "$template" "$out" \
    "%%A%%=x/y&z|w" \
    "%%B%%=hello"

  assert_eq "A=x/y&z|w" "$(sed -n '1p' "$out")" "render_template A" || return 1
  assert_eq "B=hello"   "$(sed -n '2p' "$out")" "render_template B" || return 1
  pass "render_template"
}

test_version_reverse_sort_stable_before_prerelease() {
  local input out
  input=$'3.6.0rc1\n3.6.0\n'
  out="$(version_reverse_sort <<<"$input")"
  assert_eq "3.6.0" "$(sed -n '1p' <<<"$out")" "stable before rc" || return 1
  pass "version_reverse_sort: stable before prerelease"
}

test_select_postgis_src_version_for_alpine() {
  local versions src

  # Real-world snippet (stable first, then prereleases).
  versions="3.6.1 3.6.0 3.6.0rc2 3.6.0rc1 3.6.0beta1 3.6.0alpha1 3.5.4"
  src="$(select_postgis_src_version_for_alpine "3.6" "3.6" "$versions")"
  assert_eq "3.6.1" "$src" "select stable latest for series" || return 1
  pass "select_postgis_src_version_for_alpine: picks latest stable"

  # No stable release available; requested is prerelease => use requested.
  versions="3.6.0rc2 3.6.0beta1 3.6.0alpha1"
  src="$(select_postgis_src_version_for_alpine "3.6" "3.6.0beta1" "$versions")"
  assert_eq "3.6.0beta1" "$src" "fallback to requested prerelease" || return 1
  pass "select_postgis_src_version_for_alpine: falls back to requested prerelease"

  # No stable release; requested is not prerelease => use latest available tag (may be rc/beta/alpha).
  versions="3.6.0rc2 3.6.0beta1"
  src="$(select_postgis_src_version_for_alpine "3.6" "3.6" "$versions")"
  assert_eq "3.6.0rc2" "$src" "fallback to latest available" || return 1
  pass "select_postgis_src_version_for_alpine: falls back to latest available"
}

main_tests() {
  test_build_tags_latest_and_alpine || true
  test_build_tags_prerelease || true
  test_detect_optimized_bucket || true
  test_build_tags_realworld_prerelease_examples || true
  test_render_template || true
  test_version_reverse_sort_stable_before_prerelease || true
  test_select_postgis_src_version_for_alpine || true

  echo "[INFO] Passed: ${pass_count}, Failed: ${fail_count}"
  if [[ "$fail_count" -ne 0 ]]; then
    exit 1
  fi
}

main_tests "$@"
