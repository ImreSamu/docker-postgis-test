#!/usr/bin/env bash
#
# test-image.sh - Run official-images test suite against a PostGIS image
#
set -Eeuo pipefail

# --- Logging (CI-only, no colors) ---
log_info()  { echo "[INFO] $*" >&2; }
log_warn()  { echo "[WARN] $*" >&2; }
log_error() { echo "[ERROR] $*" >&2; }
die()       { log_error "$1"; exit "${2:-1}"; }

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

image_tag="${1:-${CI_IMAGE_TAG:-}}"
log_file="${TEST_LOG_FILE:-test.log}"
official_images_dir="official-images"
official_run="./${official_images_dir}/test/run.sh"
official_config="./${official_images_dir}/test/config.sh"

if [[ -z "$image_tag" ]]; then
  die "Usage: ci/test-image.sh <image-tag>" 2
fi

if [[ "${GITHUB_ACTIONS:-}" != "true" ]]; then
  if [[ -d "${official_images_dir}/.git" ]]; then
    log_info "Local run: updating ./${official_images_dir} checkout..."
    (
      cd "$official_images_dir"
      if git remote update --prune; then
        if git show-ref --quiet refs/remotes/origin/master; then
          git reset --hard origin/master
        elif git show-ref --quiet refs/remotes/origin/main; then
          git reset --hard origin/main
        else
          log_warn "Could not detect origin/master or origin/main; leaving checkout unchanged."
        fi
      else
        log_warn "Failed to update official-images; using existing checkout."
      fi
    )
  elif [[ ! -d "$official_images_dir" ]]; then
    log_info "Local run: ./${official_images_dir} is missing; cloning docker-library/official-images..."
    if ! command -v git >/dev/null 2>&1; then
      log_error "git is required to clone official-images."
      log_info "Run locally:"
      log_info "  git clone https://github.com/docker-library/official-images.git ${official_images_dir}"
      exit 1
    fi
    if ! git clone --depth 1 https://github.com/docker-library/official-images.git "${official_images_dir}"; then
      log_error "Failed to clone official-images."
      log_info "Retry locally with:"
      log_info "  git clone https://github.com/docker-library/official-images.git ${official_images_dir}"
      exit 1
    fi
  else
    log_warn "./${official_images_dir} exists but is not a git checkout; skipping update."
  fi
fi

if [[ ! -x "$official_run" ]]; then
  die "${official_run} not found or not executable."
fi
if [[ ! -f "$official_config" ]]; then
  die "${official_config} not found."
fi

"$official_run" -c "$official_config" -c test/postgis-config.sh "$image_tag" | tee "$log_file"

required_tests=("postgres-basics" "postgres-initdb" "postgis-basics")
for test_name in "${required_tests[@]}"; do
  if ! grep -q "'${test_name}'.*passed" "$log_file"; then
    die "Required test '${test_name}' did not pass!"
  fi
done

log_info "[OK] All required tests passed"
