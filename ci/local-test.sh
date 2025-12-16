#!/usr/bin/env bash
#
# local-test.sh - Build and test PostGIS images locally
#
# Usage: ci/local-test.sh [OPTIONS] [TAG-PATTERN...]
#
set -Eeuo pipefail

# --- Logging (CLI with colors) ---
if [[ -t 2 ]]; then
    readonly C_RED='\033[0;31m' C_CYAN='\033[0;36m' C_RESET='\033[0m'
else
    readonly C_RED='' C_CYAN='' C_RESET=''
fi
log_info()  { printf '%b[INFO]%b %s\n' "$C_CYAN" "$C_RESET" "$*" >&2; }
log_error() { printf '%b[ERROR]%b %s\n' "$C_RED" "$C_RESET" "$*" >&2; }
die()       { log_error "$1"; exit "${2:-1}"; }

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

# Local image repository used for `docker build -t`.
# Keep this aligned with `test/postgis-config.sh` (it expects the postgis/postgis repo name).
local_image_repo="postgis/postgis"

with_registry=false
keep_registry=false
registry_addr="localhost:5000"
registry_container="local-registry-ci"
patterns=()

runtime="$(date +%Y%m%d-%H%M%S)"
log_dir="${repo_root}/_build_log/${runtime}"

usage() {
  cat <<'EOF'
Usage: ci/local-test.sh [options] [tag-pattern ...]

Options:
  --with-registry       Also push native images to a local registry and run
                        ci/push-manifest.sh using local digests.
  --registry host:port  Registry address (default: localhost:5000).
  --keep-registry       Leave the registry container running if started here.
  -h, --help            Show this help.

Tag patterns:
  One or more Bash glob patterns matched against the per-target `tags` values
  in `matrix.yml`. If any tag of a target matches any pattern, that target is
  selected.
  Examples:
    17-master
    '*-alpine'
    '*-bullseye'
    '1*-3.5'
  Use `--` before patterns that start with `-`.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-registry) with_registry=true; shift ;;
    --keep-registry) keep_registry=true; shift ;;
    --registry) registry_addr="${2:-}"; shift 2 ;;
    --) shift; patterns+=("$@"); break ;;
    -h|--help) usage; exit 0 ;;
    *) patterns+=("$1"); shift ;;
  esac
done

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Required command not found on PATH: $1"
}

require_cmd yq
require_cmd jq
require_cmd docker

registry_created=false
start_registry() {
  local host="${registry_addr%%:*}"
  local port="${registry_addr##*:}"

  if [[ ! "$host" =~ ^(localhost|127\.0\.0\.1)$ ]]; then
    log_info "Using remote registry ${registry_addr} (not auto-starting)"
    return 0
  fi

  if docker ps --format '{{.Names}}' | grep -qx "$registry_container"; then
    log_info "Local registry already running: ${registry_container}"
    return 0
  fi

  if docker ps -a --format '{{.Names}}' | grep -qx "$registry_container"; then
    log_info "Starting existing registry container: ${registry_container}"
    docker start "$registry_container" >/dev/null
    return 0
  fi

  log_info "Starting local registry (${registry_container}) on ${registry_addr}"
  docker run -d -p "${port}:5000" --name "$registry_container" registry:3 >/dev/null
  registry_created=true
}

cleanup_registry() {
  if [[ "$registry_created" == "true" && "$keep_registry" == "false" ]]; then
    log_info "Stopping local registry container: ${registry_container}"
    docker rm -f "$registry_container" >/dev/null || true
  fi
}
trap cleanup_registry EXIT

matches_patterns() {
  local tags_str="$1"
  shift
  local -a pats=( "$@" )
  if [[ "${#pats[@]}" -eq 0 ]]; then
    return 0
  fi

  local tag pat
  for tag in $tags_str; do
    for pat in "${pats[@]}"; do
      # shellcheck disable=SC2053  # Intentional glob matching
      if [[ "$tag" == $pat ]]; then
        return 0
      fi
    done
  done
  return 1
}

sanitize_filename() {
  local s="$1"
  # Replace characters that may be problematic in filenames.
  s="${s//[^a-zA-Z0-9._-]/_}"
  echo "$s"
}

# Reuse ci/matrix.sh so it is exercised locally too.
if [[ -z "${RUNNER_PLATFORMS_JSON:-}" ]]; then
  export RUNNER_PLATFORMS_JSON='["local"]'
fi

matrix_out="$(mktemp)"
bash ci/matrix.sh | tee "$matrix_out" >/dev/null

targets_line="$(grep '^BUILD_TARGETS=' "$matrix_out" | tail -n 1 || true)"
targets_json="${targets_line#BUILD_TARGETS=}"
rm -f "$matrix_out"
target_count="$(jq 'length' <<< "$targets_json" 2>/dev/null || echo 0)"
if [[ "$target_count" -eq 0 ]]; then
  die "No build_targets found (ci/matrix.sh output missing BUILD_TARGETS)"
fi

if [[ "$with_registry" == "true" ]]; then
  if ! docker buildx version >/dev/null 2>&1; then
    die "Docker Buildx is required (docker buildx)"
  fi
  start_registry
  log_info "Running local build+test+manifest on native platform"
else
  log_info "Running local build+test on native platform only"
fi

selected_indices=()
for ((i=0; i<target_count; i++)); do
  entry_tags="$(jq -r ".[$i].tags" <<< "$targets_json")"
  if matches_patterns "$entry_tags" "${patterns[@]}"; then
    selected_indices+=( "$i" )
  fi
done

selected_count="${#selected_indices[@]}"
if [[ "$selected_count" -eq 0 ]]; then
  die "No targets match patterns: ${patterns[*]:-(none)}"
fi

if [[ "${#patterns[@]}" -gt 0 ]]; then
  log_info "Selected ${selected_count}/${target_count} targets by patterns: ${patterns[*]}"
else
  log_info "Selected all ${selected_count} targets"
fi

mkdir -p "$log_dir"
log_info "Logs will be saved to ${log_dir}"

for sel_pos in "${!selected_indices[@]}"; do
  i="${selected_indices[$sel_pos]}"
  postgres="$(jq -r ".[$i].postgres" <<< "$targets_json")"
  postgis="$(jq -r ".[$i].postgis" <<< "$targets_json")"
  variant="$(jq -r ".[$i].variant" <<< "$targets_json")"
  entry_tags="$(jq -r ".[$i].tags" <<< "$targets_json")"

  first_tag="${entry_tags%% *}"
  if [[ -z "$first_tag" ]]; then
    first_tag="${postgres}-${postgis}${variant:+-${variant}}"
  fi
  base_name="$(sanitize_filename "$first_tag")"
  build_log="${log_dir}/${base_name}-build.log"
  test_log="${log_dir}/${base_name}-test.log"

  version_dir="${postgres}-${postgis}"
  if [[ "$variant" == "alpine" ]]; then
    build_dir="${version_dir}/alpine"
    variant_suffix="-alpine"
    tag="${local_image_repo}:local-${version_dir}-alpine"
  else
    build_dir="${version_dir}"
    variant_suffix=""
    tag="${local_image_repo}:local-${version_dir}"
  fi

  dockerfile="${build_dir}/Dockerfile"
  if [[ ! -f "$dockerfile" ]]; then
    die "Dockerfile not found: ${dockerfile}"
  fi

  log_info "[$((sel_pos+1))/${selected_count}] Building ${tag} from ${build_dir}"
  docker build -t "$tag" -f "$dockerfile" "$build_dir" 2>&1 | tee "$build_log"

  log_info "Testing ${tag}"
  TEST_LOG_FILE="$test_log" bash ci/test-image.sh "$tag"

  if [[ "$with_registry" == "true" ]]; then
    registry_repo="${registry_addr}/${local_image_repo}"
    temp_push_tag="${registry_repo}:ci-local-${version_dir}${variant_suffix}"

    log_info "Pushing native image to local registry: ${temp_push_tag}"
    docker tag "$tag" "$temp_push_tag"
    docker push "$temp_push_tag" >/dev/null

    digest_full="$(docker inspect --format='{{index .RepoDigests 0}}' "$temp_push_tag")"
    digest="${digest_full#*@sha256:}"
    digests_dir="$(mktemp -d)"
    touch "${digests_dir}/${digest}"

    build_month="$(date +%Y%m)"
    read -r -a tags_arr <<< "$entry_tags"
    extra_tags=""
    if [[ "${#tags_arr[@]}" -ge 2 ]]; then
      extra_tags+=" ${tags_arr[1]}-${build_month}"
    fi
    log_info "Creating manifest(s) in local registry for tags: ${entry_tags}${extra_tags}"
    bash ci/push-manifest.sh "$registry_repo" "${entry_tags}${extra_tags}" "$digests_dir"
    rm -rf "$digests_dir"
  fi
done

if [[ "$with_registry" == "true" ]]; then
  log_info "Preparing Docker Hub README (local dry run)"
  dockerhub_readme_out="${repo_root}/_DOCKER-HUB-README.md"
  bash ci/prepare-dockerhub-readme.sh README.md "$dockerhub_readme_out"
  log_info "Docker Hub README written to ${dockerhub_readme_out}"
fi

echo "[OK] Local matrix build+test complete"
