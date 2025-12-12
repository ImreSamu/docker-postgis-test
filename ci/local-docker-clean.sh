#!/usr/bin/env bash
set -euo pipefail

log()  { echo "[INFO] $*"; }
warn() { echo "[WARN] $*" >&2; }
die()  { echo "[ERROR] $*" >&2; exit 1; }

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
    log "No images matched: $ref"
    return 0
  fi

  log "Matched $ref:"
  for id in "${ids[@]}"; do
    echo "  $id"
  done

  if [[ "$dry_run" == "true" ]]; then
    return 0
  fi

  # shellcheck disable=SC2086
  docker rmi -f "${ids[@]}" >/dev/null || warn "Some images could not be removed for: $ref"
  log "[OK] Removed images for: $ref"
}

delete_images_by_ref "${local_image_repo}:local-*"
delete_images_by_ref "${local_registry}/${local_image_repo}:*"
delete_images_by_ref "librarytest/postgres-initdb:*"

log "[OK] Local docker test images cleaned"

