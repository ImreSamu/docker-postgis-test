#!/usr/bin/env bash
#
# local-docker-clean.sh - Clean up local CI/test Docker images
#
# Usage: ci/local-docker-clean.sh [--dry-run]
#
set -Eeuo pipefail

# --- Logging (CLI with colors) ---
if [[ -t 2 ]]; then
    readonly C_RED='\033[0;31m' C_YELLOW='\033[0;33m' C_CYAN='\033[0;36m' C_RESET='\033[0m'
else
    readonly C_RED='' C_YELLOW='' C_CYAN='' C_RESET=''
fi
log_info()  { printf '%b[INFO]%b %s\n' "$C_CYAN" "$C_RESET" "$*" >&2; }
log_warn()  { printf '%b[WARN]%b %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }
log_error() { printf '%b[ERROR]%b %s\n' "$C_RED" "$C_RESET" "$*" >&2; }
die()       { log_error "$1"; exit "${2:-1}"; }

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

# Keep aligned with ci/local-test.sh
local_image_repo="${LOCAL_IMAGE_REPO:-postgis/postgis}"
local_registry="${LOCAL_REGISTRY:-localhost:5000}"

dry_run=false
usage() {
  cat <<EOF
Usage: ci/local-docker-clean.sh [--dry-run]

Deletes local CI/test Docker images:
  - ${local_image_repo}:local-*
  - ${local_registry}/${local_image_repo}:*
  - librarytest/postgres-initdb:*
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) dry_run=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown argument: $1" ;;
  esac
done

command -v docker >/dev/null 2>&1 || die "docker not found"

delete_images_by_ref() {
  local ref="$1"
  local -a ids=()
  mapfile -t ids < <(docker images --no-trunc --quiet "$ref" 2>/dev/null | sort -u)

  if [[ "${#ids[@]}" -eq 0 ]]; then
    log_info "No images matched: $ref"
    return 0
  fi

  log_info "Matched $ref:"
  for id in "${ids[@]}"; do
    echo "  $id"
  done

  if [[ "$dry_run" == "true" ]]; then
    return 0
  fi

  # shellcheck disable=SC2086
  docker rmi -f "${ids[@]}" >/dev/null || log_warn "Some images could not be removed for: $ref"
  log_info "[OK] Removed images for: $ref"
}

delete_images_by_ref "${local_image_repo}:local-*"
delete_images_by_ref "${local_registry}/${local_image_repo}:*"
delete_images_by_ref "librarytest/postgres-initdb:*"

log_info "[OK] Local docker test images cleaned"
