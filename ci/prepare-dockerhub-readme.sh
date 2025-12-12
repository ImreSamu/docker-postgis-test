#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

src_readme="${1:-README.md}"
out_readme="${2:-_DOCKER-HUB-README.md}"
prefix="${DOCKERHUB_README_PREFIX:-}"

if [[ ! -f "$src_readme" ]]; then
  echo "ERROR: Source README not found: $src_readme" >&2
  exit 1
fi

mkdir -p "$(dirname "$out_readme")"

tmp_file="$(mktemp)"
if [[ -n "$prefix" ]]; then
  printf '%b\n' "$prefix" > "$tmp_file"
  cat "$src_readme" >> "$tmp_file"
else
  cat "$src_readme" > "$tmp_file"
fi
mv "$tmp_file" "$out_readme"

readme_path="$out_readme"

# Docker Hub README limit is 25000 chars; trim earlier to stay safe.
limit=24600
size="$(wc -c < "$readme_path" | tr -d '[:space:]')"

if [[ "$size" -ge "$limit" ]]; then
  repo="${GITHUB_REPO:-${GITHUB_REPOSITORY:-unknown/unknown}}"
  warning_text=$'Note: the description for this image is longer than the Hub length limit of 25000, so has been trimmed. The full description can be found at\n"https://github.com/'"${repo}"$'/README.md"'

  start_block="${warning_text}"$'\n\n'
  end_block=$'\n...\n'"${warning_text}"$'\n'

  start_len="$(printf '%s' "$start_block" | wc -c | tr -d '[:space:]')"
  end_len="$(printf '%s' "$end_block" | wc -c | tr -d '[:space:]')"
  avail=$(( limit - start_len - end_len ))

  if (( avail < 0 )); then
    echo "ERROR: Trimming blocks exceed limit ${limit}" >&2
    avail=0
  fi

  content_tmp="$(mktemp)"
  current=0
  while IFS= read -r line || [[ -n "$line" ]]; do
    line_with_nl="${line}"$'\n'
    line_len="$(printf '%s' "$line_with_nl" | wc -c | tr -d '[:space:]')"
    if (( current + line_len > avail )); then
      break
    fi
    printf '%s' "$line_with_nl" >> "$content_tmp"
    current=$(( current + line_len ))
  done < "$readme_path"

  final_tmp="$(mktemp)"
  printf '%s' "$start_block" > "$final_tmp"
  cat "$content_tmp" >> "$final_tmp"
  printf '%s' "$end_block" >> "$final_tmp"
  mv "$final_tmp" "$readme_path"
fi

echo "[OK] Docker Hub README prepared: $out_readme"
