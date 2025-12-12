#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

image_tag="${1:-${CI_IMAGE_TAG:-}}"
log_file="${TEST_LOG_FILE:-test.log}"
official_images_dir="official-images"
official_run="./${official_images_dir}/test/run.sh"
official_config="./${official_images_dir}/test/config.sh"

if [[ -z "$image_tag" ]]; then
  echo "Usage: ci/test-image.sh <image-tag>" >&2
  exit 2
fi

if [[ "${GITHUB_ACTIONS:-}" != "true" ]]; then
  if [[ -d "${official_images_dir}/.git" ]]; then
    echo "Local run: updating ./${official_images_dir} checkout..." >&2
    (
      cd "$official_images_dir"
      if git remote update --prune; then
        if git show-ref --quiet refs/remotes/origin/master; then
          git reset --hard origin/master
        elif git show-ref --quiet refs/remotes/origin/main; then
          git reset --hard origin/main
        else
          echo "WARNING: Could not detect origin/master or origin/main; leaving checkout unchanged." >&2
        fi
      else
        echo "WARNING: Failed to update official-images; using existing checkout." >&2
      fi
    )
  elif [[ ! -d "$official_images_dir" ]]; then
    echo "Local run: ./${official_images_dir} is missing; cloning docker-library/official-images..." >&2
    if ! command -v git >/dev/null 2>&1; then
      echo "ERROR: git is required to clone official-images." >&2
      echo "Run locally:" >&2
      echo "  git clone https://github.com/docker-library/official-images.git ${official_images_dir}" >&2
      exit 1
    fi
    if ! git clone --depth 1 https://github.com/docker-library/official-images.git "${official_images_dir}"; then
      echo "ERROR: Failed to clone official-images." >&2
      echo "Retry locally with:" >&2
      echo "  git clone https://github.com/docker-library/official-images.git ${official_images_dir}" >&2
      exit 1
    fi
  else
    echo "WARNING: ./${official_images_dir} exists but is not a git checkout; skipping update." >&2
  fi
fi

if [[ ! -x "$official_run" ]]; then
  echo "ERROR: ${official_run} not found or not executable." >&2
  exit 1
fi
if [[ ! -f "$official_config" ]]; then
  echo "ERROR: ${official_config} not found." >&2
  exit 1
fi

"$official_run" -c "$official_config" -c test/postgis-config.sh "$image_tag" | tee "$log_file"

required_tests=("postgres-basics" "postgres-initdb" "postgis-basics")
for test_name in "${required_tests[@]}"; do
  if ! grep -q "'${test_name}'.*passed" "$log_file"; then
    echo "ERROR: Required test '${test_name}' did not pass!" >&2
    exit 1
  fi
done

echo "[OK] All required tests passed"
