#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="./xray"
TEMPLATE_FILE="${CONFIG_DIR}/default.nix"
VERSIONS_DIR="${CONFIG_DIR}/versions"
OUTPUT_PREFIX="${VERSIONS_DIR}/gen"

# Ensure versions directory exists
mkdir -p "${VERSIONS_DIR}"

# Find the latest generation number
LATEST_GEN=$(find "${VERSIONS_DIR}" -name 'gen*.json' 2>/dev/null | \
              grep -oE 'gen[0-9]+\.json' | \
              sed 's/gen\([0-9]*\)\.json/\1/' | \
              sort -n | tail -n 1) || LATEST_GEN=0

# Increment generation number
NEW_GEN=$((LATEST_GEN + 1))
TMP_FILE=$(mktemp)  # Temporary file to avoid partial writes
FINAL_FILE="${OUTPUT_PREFIX}${NEW_GEN}.json"

echo "🔄 Generating Xray config (gen${NEW_GEN}.json)..."

# Generate config to a temp file first
if ! nix eval --json --expr "import ${TEMPLATE_FILE}" --impure > "${TMP_FILE}"; then
    echo "❌ nix eval failed! No config generated." >&2
    rm -f "${TMP_FILE}"  # Clean up temp file
    exit 1
fi

# Verify JSON is non-empty
if [[ ! -s "${TMP_FILE}" ]]; then
    echo "❌ Generated config is empty! Check your Nix expression." >&2
    rm -f "${TMP_FILE}"
    exit 1
fi

# Move temp file to final location
mv "${TMP_FILE}" "${FINAL_FILE}"
echo "✅ Successfully created: ${FINAL_FILE}"
exit 0
