#!/usr/bin/env bash
set -Eeuo pipefail
# Source environment variables and necessary configurations
source tools/environment_init.sh
[ -f ./versions.json ]

#
# Updating the docker manifest for the postgis image.
# This script uses the version.json metadata file as input to create the updated manifest.
#   manifest-tool doc : https://github.com/estesp/manifest-tool
#
# NOTE: THIS FILE IS GENERATED VIA "./tools/apply-manifest.sh"
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# ----- 13-3.3-alpine3.21 -----

echo "manifest: ${dockername}:13-3.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.3-alpine3.21 \
    --target ${dockername}:13-3.3-alpine3.21 || true

echo "manifest: ${dockername}:13-3.3.8-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.3.8-alpine3.21 \
    --target ${dockername}:13-3.3.8-alpine3.21 || true

# ----- 13-3.4-alpine3.21 -----

echo "manifest: ${dockername}:13-3.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.4-alpine3.21 \
    --target ${dockername}:13-3.4-alpine3.21 || true

echo "manifest: ${dockername}:13-3.4.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.4.4-alpine3.21 \
    --target ${dockername}:13-3.4.4-alpine3.21 || true

# ----- 13-3.4-alpine3.22 -----

echo "manifest: ${dockername}:13-3.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.4-alpine3.22 \
    --target ${dockername}:13-3.4-alpine3.22 || true

echo "manifest: ${dockername}:13-3.4.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.4.4-alpine3.22 \
    --target ${dockername}:13-3.4.4-alpine3.22 || true

echo "manifest: ${dockername}:13-3.4-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.4-alpine \
    --target ${dockername}:13-3.4-alpine || true

# ----- 13-3.5-alpine3.21 -----

echo "manifest: ${dockername}:13-3.5-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.5-alpine3.21 \
    --target ${dockername}:13-3.5-alpine3.21 || true

echo "manifest: ${dockername}:13-3.5.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.5.3-alpine3.21 \
    --target ${dockername}:13-3.5.3-alpine3.21 || true

# ----- 13-3.5-alpine3.22 -----

echo "manifest: ${dockername}:13-3.5-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.5-alpine3.22 \
    --target ${dockername}:13-3.5-alpine3.22 || true

echo "manifest: ${dockername}:13-3.5.3-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.5.3-alpine3.22 \
    --target ${dockername}:13-3.5.3-alpine3.22 || true

echo "manifest: ${dockername}:13-3.5-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.5-alpine \
    --target ${dockername}:13-3.5-alpine || true

# ----- 13-3.6-alpine3.21 -----

echo "manifest: ${dockername}:13-3.6-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6-alpine3.21 \
    --target ${dockername}:13-3.6-alpine3.21 || true

echo "manifest: ${dockername}:13-3.6.0-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6.0-alpine3.21 \
    --target ${dockername}:13-3.6.0-alpine3.21 || true

# ----- 13-3.6-alpine3.22 -----

echo "manifest: ${dockername}:13-3.6-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6-alpine3.22 \
    --target ${dockername}:13-3.6-alpine3.22 || true

echo "manifest: ${dockername}:13-3.6.0-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6.0-alpine3.22 \
    --target ${dockername}:13-3.6.0-alpine3.22 || true

echo "manifest: ${dockername}:13-3.6-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6-alpine \
    --target ${dockername}:13-3.6-alpine || true

# ----- 13-3.6-bookworm -----

echo "manifest: ${dockername}:13-3.6-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6-bookworm \
    --target ${dockername}:13-3.6-bookworm || true

echo "manifest: ${dockername}:13-3.6.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6.0-bookworm \
    --target ${dockername}:13-3.6.0-bookworm || true

# ----- 13-3.6-trixie -----

echo "manifest: ${dockername}:13-3.6-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6-trixie \
    --target ${dockername}:13-3.6-trixie || true

echo "manifest: ${dockername}:13-3.6.0-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6.0-trixie \
    --target ${dockername}:13-3.6.0-trixie || true

echo "manifest: ${dockername}:13-3.6"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:13-3.6 \
    --target ${dockername}:13-3.6 || true

# ----- 14-3.3-alpine3.21 -----

echo "manifest: ${dockername}:14-3.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.3-alpine3.21 \
    --target ${dockername}:14-3.3-alpine3.21 || true

echo "manifest: ${dockername}:14-3.3.8-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.3.8-alpine3.21 \
    --target ${dockername}:14-3.3.8-alpine3.21 || true

# ----- 14-3.4-alpine3.21 -----

echo "manifest: ${dockername}:14-3.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.4-alpine3.21 \
    --target ${dockername}:14-3.4-alpine3.21 || true

echo "manifest: ${dockername}:14-3.4.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.4.4-alpine3.21 \
    --target ${dockername}:14-3.4.4-alpine3.21 || true

# ----- 14-3.4-alpine3.22 -----

echo "manifest: ${dockername}:14-3.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.4-alpine3.22 \
    --target ${dockername}:14-3.4-alpine3.22 || true

echo "manifest: ${dockername}:14-3.4.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.4.4-alpine3.22 \
    --target ${dockername}:14-3.4.4-alpine3.22 || true

echo "manifest: ${dockername}:14-3.4-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.4-alpine \
    --target ${dockername}:14-3.4-alpine || true

# ----- 14-3.5-alpine3.21 -----

echo "manifest: ${dockername}:14-3.5-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.5-alpine3.21 \
    --target ${dockername}:14-3.5-alpine3.21 || true

echo "manifest: ${dockername}:14-3.5.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.5.3-alpine3.21 \
    --target ${dockername}:14-3.5.3-alpine3.21 || true

# ----- 14-3.5-alpine3.22 -----

echo "manifest: ${dockername}:14-3.5-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.5-alpine3.22 \
    --target ${dockername}:14-3.5-alpine3.22 || true

echo "manifest: ${dockername}:14-3.5.3-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.5.3-alpine3.22 \
    --target ${dockername}:14-3.5.3-alpine3.22 || true

echo "manifest: ${dockername}:14-3.5-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.5-alpine \
    --target ${dockername}:14-3.5-alpine || true

# ----- 14-3.6-alpine3.21 -----

echo "manifest: ${dockername}:14-3.6-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6-alpine3.21 \
    --target ${dockername}:14-3.6-alpine3.21 || true

echo "manifest: ${dockername}:14-3.6.0-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6.0-alpine3.21 \
    --target ${dockername}:14-3.6.0-alpine3.21 || true

# ----- 14-3.6-alpine3.22 -----

echo "manifest: ${dockername}:14-3.6-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6-alpine3.22 \
    --target ${dockername}:14-3.6-alpine3.22 || true

echo "manifest: ${dockername}:14-3.6.0-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6.0-alpine3.22 \
    --target ${dockername}:14-3.6.0-alpine3.22 || true

echo "manifest: ${dockername}:14-3.6-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6-alpine \
    --target ${dockername}:14-3.6-alpine || true

# ----- 14-3.6-bookworm -----

echo "manifest: ${dockername}:14-3.6-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6-bookworm \
    --target ${dockername}:14-3.6-bookworm || true

echo "manifest: ${dockername}:14-3.6.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6.0-bookworm \
    --target ${dockername}:14-3.6.0-bookworm || true

# ----- 14-3.6-trixie -----

echo "manifest: ${dockername}:14-3.6-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6-trixie \
    --target ${dockername}:14-3.6-trixie || true

echo "manifest: ${dockername}:14-3.6.0-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6.0-trixie \
    --target ${dockername}:14-3.6.0-trixie || true

echo "manifest: ${dockername}:14-3.6"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-3.6 \
    --target ${dockername}:14-3.6 || true

# ----- 14-l3.1.9gcp-bookworm -----

echo "manifest: ${dockername}:14-l3.1.9gcp-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-l3.1.9gcp-bookworm \
    --target ${dockername}:14-l3.1.9gcp-bookworm || true

echo "manifest: ${dockername}:14-l3.1.9gcp-postgis3.1.9-geos3.6.6-proj6.3.1-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:14-l3.1.9gcp-postgis3.1.9-geos3.6.6-proj6.3.1-bookworm \
    --target ${dockername}:14-l3.1.9gcp-postgis3.1.9-geos3.6.6-proj6.3.1-bookworm || true

# ----- 15-3.3-alpine3.21 -----

echo "manifest: ${dockername}:15-3.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.3-alpine3.21 \
    --target ${dockername}:15-3.3-alpine3.21 || true

echo "manifest: ${dockername}:15-3.3.8-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.3.8-alpine3.21 \
    --target ${dockername}:15-3.3.8-alpine3.21 || true

# ----- 15-3.4-alpine3.21 -----

echo "manifest: ${dockername}:15-3.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.4-alpine3.21 \
    --target ${dockername}:15-3.4-alpine3.21 || true

echo "manifest: ${dockername}:15-3.4.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.4.4-alpine3.21 \
    --target ${dockername}:15-3.4.4-alpine3.21 || true

# ----- 15-3.4-alpine3.22 -----

echo "manifest: ${dockername}:15-3.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.4-alpine3.22 \
    --target ${dockername}:15-3.4-alpine3.22 || true

echo "manifest: ${dockername}:15-3.4.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.4.4-alpine3.22 \
    --target ${dockername}:15-3.4.4-alpine3.22 || true

echo "manifest: ${dockername}:15-3.4-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.4-alpine \
    --target ${dockername}:15-3.4-alpine || true

# ----- 15-3.5-alpine3.21 -----

echo "manifest: ${dockername}:15-3.5-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.5-alpine3.21 \
    --target ${dockername}:15-3.5-alpine3.21 || true

echo "manifest: ${dockername}:15-3.5.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.5.3-alpine3.21 \
    --target ${dockername}:15-3.5.3-alpine3.21 || true

# ----- 15-3.5-alpine3.22 -----

echo "manifest: ${dockername}:15-3.5-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.5-alpine3.22 \
    --target ${dockername}:15-3.5-alpine3.22 || true

echo "manifest: ${dockername}:15-3.5.3-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.5.3-alpine3.22 \
    --target ${dockername}:15-3.5.3-alpine3.22 || true

echo "manifest: ${dockername}:15-3.5-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.5-alpine \
    --target ${dockername}:15-3.5-alpine || true

# ----- 15-3.6-alpine3.21 -----

echo "manifest: ${dockername}:15-3.6-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6-alpine3.21 \
    --target ${dockername}:15-3.6-alpine3.21 || true

echo "manifest: ${dockername}:15-3.6.0-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6.0-alpine3.21 \
    --target ${dockername}:15-3.6.0-alpine3.21 || true

# ----- 15-3.6-alpine3.22 -----

echo "manifest: ${dockername}:15-3.6-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6-alpine3.22 \
    --target ${dockername}:15-3.6-alpine3.22 || true

echo "manifest: ${dockername}:15-3.6.0-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6.0-alpine3.22 \
    --target ${dockername}:15-3.6.0-alpine3.22 || true

echo "manifest: ${dockername}:15-3.6-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6-alpine \
    --target ${dockername}:15-3.6-alpine || true

# ----- 15-3.6-bookworm -----

echo "manifest: ${dockername}:15-3.6-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6-bookworm \
    --target ${dockername}:15-3.6-bookworm || true

echo "manifest: ${dockername}:15-3.6.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6.0-bookworm \
    --target ${dockername}:15-3.6.0-bookworm || true

# ----- 15-3.6-trixie -----

echo "manifest: ${dockername}:15-3.6-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6-trixie \
    --target ${dockername}:15-3.6-trixie || true

echo "manifest: ${dockername}:15-3.6.0-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6.0-trixie \
    --target ${dockername}:15-3.6.0-trixie || true

echo "manifest: ${dockername}:15-3.6"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:15-3.6 \
    --target ${dockername}:15-3.6 || true

# ----- 16-3.3-alpine3.21 -----

echo "manifest: ${dockername}:16-3.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.3-alpine3.21 \
    --target ${dockername}:16-3.3-alpine3.21 || true

echo "manifest: ${dockername}:16-3.3.8-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.3.8-alpine3.21 \
    --target ${dockername}:16-3.3.8-alpine3.21 || true

# ----- 16-3.4-alpine3.21 -----

echo "manifest: ${dockername}:16-3.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.4-alpine3.21 \
    --target ${dockername}:16-3.4-alpine3.21 || true

echo "manifest: ${dockername}:16-3.4.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.4.4-alpine3.21 \
    --target ${dockername}:16-3.4.4-alpine3.21 || true

# ----- 16-3.4-alpine3.22 -----

echo "manifest: ${dockername}:16-3.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.4-alpine3.22 \
    --target ${dockername}:16-3.4-alpine3.22 || true

echo "manifest: ${dockername}:16-3.4.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.4.4-alpine3.22 \
    --target ${dockername}:16-3.4.4-alpine3.22 || true

echo "manifest: ${dockername}:16-3.4-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.4-alpine \
    --target ${dockername}:16-3.4-alpine || true

# ----- 16-3.6-alpine3.21 -----

echo "manifest: ${dockername}:16-3.6-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6-alpine3.21 \
    --target ${dockername}:16-3.6-alpine3.21 || true

echo "manifest: ${dockername}:16-3.6.0-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6.0-alpine3.21 \
    --target ${dockername}:16-3.6.0-alpine3.21 || true

# ----- 16-3.6-alpine3.22 -----

echo "manifest: ${dockername}:16-3.6-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6-alpine3.22 \
    --target ${dockername}:16-3.6-alpine3.22 || true

echo "manifest: ${dockername}:16-3.6.0-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6.0-alpine3.22 \
    --target ${dockername}:16-3.6.0-alpine3.22 || true

echo "manifest: ${dockername}:16-3.6-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6-alpine \
    --target ${dockername}:16-3.6-alpine || true

# ----- 16-3.6-bookworm -----

echo "manifest: ${dockername}:16-3.6-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6-bookworm \
    --target ${dockername}:16-3.6-bookworm || true

echo "manifest: ${dockername}:16-3.6.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6.0-bookworm \
    --target ${dockername}:16-3.6.0-bookworm || true

# ----- 16-3.6-trixie -----

echo "manifest: ${dockername}:16-3.6-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6-trixie \
    --target ${dockername}:16-3.6-trixie || true

echo "manifest: ${dockername}:16-3.6.0-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6.0-trixie \
    --target ${dockername}:16-3.6.0-trixie || true

echo "manifest: ${dockername}:16-3.6"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:16-3.6 \
    --target ${dockername}:16-3.6 || true

# ----- 17-3.4-alpine3.21 -----

echo "manifest: ${dockername}:17-3.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.4-alpine3.21 \
    --target ${dockername}:17-3.4-alpine3.21 || true

echo "manifest: ${dockername}:17-3.4.4-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.4.4-alpine3.21 \
    --target ${dockername}:17-3.4.4-alpine3.21 || true

# ----- 17-3.4-alpine3.22 -----

echo "manifest: ${dockername}:17-3.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.4-alpine3.22 \
    --target ${dockername}:17-3.4-alpine3.22 || true

echo "manifest: ${dockername}:17-3.4.4-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.4.4-alpine3.22 \
    --target ${dockername}:17-3.4.4-alpine3.22 || true

echo "manifest: ${dockername}:17-3.4-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.4-alpine \
    --target ${dockername}:17-3.4-alpine || true

# ----- 17-3.5-alpine3.21 -----

echo "manifest: ${dockername}:17-3.5-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.5-alpine3.21 \
    --target ${dockername}:17-3.5-alpine3.21 || true

echo "manifest: ${dockername}:17-3.5.3-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.5.3-alpine3.21 \
    --target ${dockername}:17-3.5.3-alpine3.21 || true

# ----- 17-3.5-alpine3.22 -----

echo "manifest: ${dockername}:17-3.5-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.5-alpine3.22 \
    --target ${dockername}:17-3.5-alpine3.22 || true

echo "manifest: ${dockername}:17-3.5.3-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.5.3-alpine3.22 \
    --target ${dockername}:17-3.5.3-alpine3.22 || true

echo "manifest: ${dockername}:17-3.5-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.5-alpine \
    --target ${dockername}:17-3.5-alpine || true

# ----- 17-3.6-alpine3.21 -----

echo "manifest: ${dockername}:17-3.6-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6-alpine3.21 \
    --target ${dockername}:17-3.6-alpine3.21 || true

echo "manifest: ${dockername}:17-3.6.0-alpine3.21"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6.0-alpine3.21 \
    --target ${dockername}:17-3.6.0-alpine3.21 || true

# ----- 17-3.6-alpine3.22 -----

echo "manifest: ${dockername}:17-3.6-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6-alpine3.22 \
    --target ${dockername}:17-3.6-alpine3.22 || true

echo "manifest: ${dockername}:17-3.6.0-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6.0-alpine3.22 \
    --target ${dockername}:17-3.6.0-alpine3.22 || true

echo "manifest: ${dockername}:17-3.6-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6-alpine \
    --target ${dockername}:17-3.6-alpine || true

# ----- 17-3.6-bookworm -----

echo "manifest: ${dockername}:17-3.6-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6-bookworm \
    --target ${dockername}:17-3.6-bookworm || true

echo "manifest: ${dockername}:17-3.6.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6.0-bookworm \
    --target ${dockername}:17-3.6.0-bookworm || true

# ----- 17-3.6-trixie -----

echo "manifest: ${dockername}:17-3.6-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6-trixie \
    --target ${dockername}:17-3.6-trixie || true

echo "manifest: ${dockername}:17-3.6.0-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6.0-trixie \
    --target ${dockername}:17-3.6.0-trixie || true

echo "manifest: ${dockername}:17-3.6"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6 \
    --target ${dockername}:17-3.6 || true

# ----- 17-3.6-bundle0-bookworm -----

echo "manifest: ${dockername}:17-3.6-bundle0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6-bundle0-bookworm \
    --target ${dockername}:17-3.6-bundle0-bookworm || true

echo "manifest: ${dockername}:17-3.6.0-bundle0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-3.6.0-bundle0-bookworm \
    --target ${dockername}:17-3.6.0-bundle0-bookworm || true

# ----- 17-master-bookworm -----

echo "manifest: ${dockername}:17-master-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-master-bookworm \
    --target ${dockername}:17-master-bookworm || true

# ----- 17-recent-bookworm -----

echo "manifest: ${dockername}:17-recent-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-recent-bookworm \
    --target ${dockername}:17-recent-bookworm || true

echo "manifest: ${dockername}:17-recent-postgis3.6.0-geos3.14.0-proj9.7.0-gdal3.11.4-cgal6.1-sfcgal2.2.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-recent-postgis3.6.0-geos3.14.0-proj9.7.0-gdal3.11.4-cgal6.1-sfcgal2.2.0-bookworm \
    --target ${dockername}:17-recent-postgis3.6.0-geos3.14.0-proj9.7.0-gdal3.11.4-cgal6.1-sfcgal2.2.0-bookworm || true

echo "manifest: ${dockername}:17-recent-postgis3.6-geos3.14-proj9.7-gdal3.11-cgal6.1-sfcgal2.2-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:17-recent-postgis3.6-geos3.14-proj9.7-gdal3.11-cgal6.1-sfcgal2.2-bookworm \
    --target ${dockername}:17-recent-postgis3.6-geos3.14-proj9.7-gdal3.11-cgal6.1-sfcgal2.2-bookworm || true

# ----- 18-3.6-alpine3.22 -----

echo "manifest: ${dockername}:18-3.6-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6-alpine3.22 \
    --target ${dockername}:18-3.6-alpine3.22 || true

echo "manifest: ${dockername}:18-3.6.0-alpine3.22"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6.0-alpine3.22 \
    --target ${dockername}:18-3.6.0-alpine3.22 || true

echo "manifest: ${dockername}:18-3.6-alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6-alpine \
    --target ${dockername}:18-3.6-alpine || true

echo "manifest: ${dockername}:alpine"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:alpine \
    --target ${dockername}:alpine || true

# ----- 18-3.6-bookworm -----

echo "manifest: ${dockername}:18-3.6-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6-bookworm \
    --target ${dockername}:18-3.6-bookworm || true

echo "manifest: ${dockername}:18-3.6.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6.0-bookworm \
    --target ${dockername}:18-3.6.0-bookworm || true

# ----- 18-3.6-trixie -----

echo "manifest: ${dockername}:18-3.6-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6-trixie \
    --target ${dockername}:18-3.6-trixie || true

echo "manifest: ${dockername}:18-3.6.0-trixie"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6.0-trixie \
    --target ${dockername}:18-3.6.0-trixie || true

echo "manifest: ${dockername}:18-3.6"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-3.6 \
    --target ${dockername}:18-3.6 || true

echo "manifest: ${dockername}:latest"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:latest \
    --target ${dockername}:latest || true

# ----- 18-master-bookworm -----

echo "manifest: ${dockername}:18-master-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-master-bookworm \
    --target ${dockername}:18-master-bookworm || true

# ----- 18-recent-bookworm -----

echo "manifest: ${dockername}:18-recent-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-recent-bookworm \
    --target ${dockername}:18-recent-bookworm || true

echo "manifest: ${dockername}:18-recent-postgis3.6.0-geos3.14.0-proj9.7.0-gdal3.11.4-cgal6.1-sfcgal2.2.0-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-recent-postgis3.6.0-geos3.14.0-proj9.7.0-gdal3.11.4-cgal6.1-sfcgal2.2.0-bookworm \
    --target ${dockername}:18-recent-postgis3.6.0-geos3.14.0-proj9.7.0-gdal3.11.4-cgal6.1-sfcgal2.2.0-bookworm || true

echo "manifest: ${dockername}:18-recent-postgis3.6-geos3.14-proj9.7-gdal3.11-cgal6.1-sfcgal2.2-bookworm"
manifest-tool push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template ${dockername}-ARCHVARIANT:18-recent-postgis3.6-geos3.14-proj9.7-gdal3.11-cgal6.1-sfcgal2.2-bookworm \
    --target ${dockername}:18-recent-postgis3.6-geos3.14-proj9.7-gdal3.11-cgal6.1-sfcgal2.2-bookworm || true
