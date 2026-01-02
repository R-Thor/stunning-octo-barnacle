#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------
# bundle-repo.sh
# Creates a deterministic base64-encoded archive of the repo.
# - Sorted file order
# - Zeroed timestamps
# - No user/group metadata
# - Excludes its own output files
# ---------------------------------------------------------

REPO_DIR="${1:-.}"
ARCHIVE="repo.bundle.tar.gz"
OUTPUT="repo.bundle.b64"

echo "Bundling repository from: $REPO_DIR"
echo "Output file: $OUTPUT"

cd "$REPO_DIR"

# ---------------------------------------------------------
# Create deterministic tarball
# ---------------------------------------------------------
echo "Creating deterministic tarball..."

tar \
  --sort=name \
  --mtime="UTC 1970-01-01" \
  --owner=0 --group=0 --numeric-owner \
  --exclude="$ARCHIVE" \
  --exclude="$OUTPUT" \
  -czf "$ARCHIVE" \
  .

# ---------------------------------------------------------
# Base64 encode the tarball
# ---------------------------------------------------------
echo "Encoding archive to base64..."
base64 "$ARCHIVE" > "$OUTPUT"

echo "Done."
echo "Your base64 bundle is ready: $OUTPUT"
echo "Open that file and paste its contents into the chat."
