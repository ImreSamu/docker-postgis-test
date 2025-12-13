# CI helper scripts

This directory contains small Bash utilities used by `.github/workflows`.  
They keep the workflow YAML short and easier to read. All scripts are designed to be runnable locally as well, with a few prerequisites noted below.

## Scripts

### `ci/matrix.sh`

Purpose: load and validate the build matrix from `matrix.yml`, and emit JSON for GitHub Actions matrices.

Functions (high level):
- Read `.build_targets` from `matrix.yml` using `yq`.
- Validate required fields and that exactly one target carries the `latest` tag.
- Expand targets across runner platforms from `RUNNER_PLATFORMS_JSON`.
- Output `BUILD_TARGETS` and `BUILD_INCLUDE` to `$GITHUB_OUTPUT` (or stdout if unset).

Local notes:
- Requires `yq` and `jq` on your PATH.
- Set `RUNNER_PLATFORMS_JSON`, e.g.  
  `export RUNNER_PLATFORMS_JSON='["ubuntu-24.04","ubuntu-24.04-arm"]'`

### `ci/test-image.sh`

Purpose: run the Docker Official Images test suite against a locally built CI image and verify key tests pass.

Functions (high level):
- Ensure `./official-images/test/run.sh` and its config exist.
- If running locally and `./official-images` is a git checkout, update it.
- Run `official-images/test/run.sh` with `test/postgis-config.sh`.
- Check that `postgres-basics`, `postgres-initdb`, and `postgis-basics` passed.

Local notes:
- Requires Docker + Buildx.
- Provide an image tag argument, e.g.  
  `bash ci/test-image.sh postgis/postgis:ci-<...>`
- If `./official-images` is missing, the script will clone it automatically (needs `git` and network access).

### `ci/push-manifest.sh`

Purpose: create and push multi‑arch manifests from per‑arch digests.

Functions (high level):
- Build tag arguments from the provided tag list.
- Read digest files from a directory and call `docker buildx imagetools create`.

Local notes:
- Requires Docker + Buildx and DockerHub login.
- Publishes to the remote repository; run locally only if you intend to push.

### `ci/prepare-dockerhub-readme.sh`

Purpose: generate a Docker Hub README file with an optional prefix and safe trimming.

Functions (high level):
- Read `README.md` (or a provided source file).
- If `DOCKERHUB_README_PREFIX` is set, prepend it.
- If the result is ≥ 24,600 bytes, trim at a line boundary and add a warning block to the top and bottom.
- Write the result to `_DOCKER-HUB-README.md` (or a provided output path).

Local notes:
- Does not modify `README.md`; it writes `_DOCKER-HUB-README.md`.
- Set `GITHUB_REPO` to get the correct GitHub URL in trimming warnings.

### `ci/local-test.sh`

Purpose: convenience script to run the full `matrix.yml` locally on your native platform.

Functions (high level):
- Read `build_targets` from `matrix.yml`.
- For each target, build the Docker image once for the local architecture.
- Run `ci/test-image.sh` on each image.
- No pushing, no multi‑arch manifests; strictly sequential.

Local notes:
- Requires `yq`, `jq`, and Docker.
- Builds can be slow and will download base images.
- To also test manifest creation locally, run with a registry:
  - `bash ci/local-test.sh --with-registry`
  - Starts (or reuses) `registry:3` on `localhost:5000`, pushes native images there,
    then runs `ci/push-manifest.sh` using local digests.
  - Override the registry address with `--registry host:port`.
  - Adds an extra monthly “stamp” tag for the 2nd `matrix.yml` tag (typically the OS tag), e.g. `13-3.5-bullseye-202512`.
- You can limit which targets run by passing tag patterns that match `matrix.yml` tags:
  - `bash ci/local-test.sh 17-master`
  - `bash ci/local-test.sh '*-alpine'`
  - `bash ci/local-test.sh '1*-3.5' '*-bullseye'`

Logs:
- Build/test logs are written under `./_build_log/<runtime>/`.

### `ci/local-docker-clean.sh`

Purpose: remove local Docker images created by local CI/test runs.

Functions (high level):
- Delete `${LOCAL_IMAGE_REPO:-postgis/postgis}:local-*`
- Delete `${LOCAL_REGISTRY:-localhost:5000}/${LOCAL_IMAGE_REPO:-postgis/postgis}:*`
- Delete `librarytest/postgres-initdb:*`

Local notes:
- Use `--dry-run` to see what would be deleted.

### `ci/test-update.sh`

Purpose: small, network-free unit tests for selected `update.sh` helper functions.

Functions (high level):
- Sources `./update.sh` (without running it) and exercises helpers like `build_tags()`.

Local notes:
- Run: `bash ci/test-update.sh`
