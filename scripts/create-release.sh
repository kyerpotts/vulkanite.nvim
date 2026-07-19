#!/bin/sh
set -eu

tag=${1:?"Usage: $0 v<major>.<minor>.<patch>"}
notes="docs/release-notes-${tag}.md"

if [ ! -f "$notes" ]; then
  printf 'Release notes not found: %s\n' "$notes" >&2
  exit 1
fi

gh release create "$tag" \
  --title "Vulkanite $tag" \
  --notes-file "$notes" \
  --verify-tag \
  --fail-on-no-commits \
  --draft
