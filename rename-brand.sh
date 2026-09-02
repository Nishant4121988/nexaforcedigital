#!/usr/bin/env bash
#
# NexaMatrix -> NexaMatrix rebrand script
# Repo: Nishant4121988/nexamatrixdigital
#
# WHAT IT DOES
#   Replaces every NexaMatrix reference in every text file of the repository:
#     NexaMatrix Digital -> NexaMatrix Digital
#     NexaMatrix         -> NexaMatrix        (covers PascalCase like NexaMatrixDigital)
#     Nexamatrix         -> Nexamatrix
#     NEXAMATRIX         -> NEXAMATRIX
#     nexamatrix         -> nexamatrix        (covers nexamatrixdigital.com -> nexamatrixdigital.com,
#                                             www.nexamatrixdigital.com -> www.nexamatrixdigital.com,
#                                             info@nexamatrixdigital.com -> info@nexamatrixdigital.com)
#
# WHAT IT PROTECTS (intentionally NOT changed)
#   - The www. prefix in URLs is preserved as-is.
#   - The logo reference "nexaforce-digital-logo" (public/images/nexaforce-digital-logo.jpg)
#     is shielded before replacing and restored afterwards.
#   - Binary files (.jpg/.png images) are never touched; no file is renamed.
#   - The internal "nf-theme" localStorage key does not match any pattern and stays as-is.
#
# HOW TO RUN
#   1. Open a terminal (Git Bash on Windows, Terminal on macOS/Linux).
#   2. cd into a fresh clone of the repository root (the folder with astro.config.mjs).
#   3. bash rename-brand.sh
#   4. Review with: git diff
#   5. Commit and push (see the hints printed at the end of the script).
#
set -euo pipefail

echo "== NexaMatrix -> NexaMatrix rebrand =="

# Safety check: must run from the repository root
if [ ! -f astro.config.mjs ] || [ ! -d src ]; then
  echo "ERROR: astro.config.mjs / src not found."
  echo "Run this script from the repository root folder."
  exit 1
fi

# Find all TEXT files (-I skips binaries) containing any capitalization of nexamatrix
MATCHES=$(grep -rIl --exclude-dir=.git --exclude-dir=node_modules \
  -e 'nexamatrix' -e 'NexaMatrix' -e 'Nexamatrix' -e 'NEXAMATRIX' . || true)

if [ -z "$MATCHES" ]; then
  echo "Nothing to do - no NexaMatrix references found."
  exit 0
fi

echo "Files that will be updated:"
echo "$MATCHES" | sed 's/^/  - /'
echo

# Replace, shielding the logo reference first and restoring it at the end
echo "$MATCHES" | while IFS= read -r f; do
  sed -i.bak \
    -e 's/nexaforce-digital-logo/nexaforce-digital-logo/g' \
    -e 's/NexaMatrix/NexaMatrix/g' \
    -e 's/Nexamatrix/Nexamatrix/g' \
    -e 's/NEXAMATRIX/NEXAMATRIX/g' \
    -e 's/nexamatrix/nexamatrix/g' \
    -e 's/nexaforce-digital-logo/nexaforce-digital-logo/g' \
    "$f"
done

# Clean up sed backup files
find . -name '*.bak' -type f -not -path './.git/*' -delete

echo "Replacement complete."
echo
echo "Verification - remaining 'nexamatrix' occurrences (only logo references are expected):"
grep -rIn --exclude-dir=.git --exclude-dir=node_modules -i 'nexamatrix' . || echo "  (none found)"
echo
echo "Next steps:"
echo "  1) Review the changes:    git diff"
echo "  2) Commit and push:"
echo "       git add -A"
echo "       git commit -m \"Rebrand: NexaMatrix -> NexaMatrix, domain -> nexamatrixdigital.com\""
echo "       git push origin main"
echo "  3) The push triggers your GitHub Actions workflow and deploys the site."
