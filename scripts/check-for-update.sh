#!/bin/bash

URL="https://raw.githubusercontent.com/holistics/dbml/master/dbml-playground/src/components/monaco/dbml-language.ts"
STORED_FILE="upstream-source/dbml-language.ts"

# Fetch latest source and overwrite stored file
curl -s "$URL" -o "$STORED_FILE"

# Check for diffs using git (assumes git repo is initialized and STORED_FILE is committed)
if git diff --quiet HEAD "$STORED_FILE" 2>/dev/null; then
  echo "No changes detected."
  echo "DIFF_FOUND=0" >> $GITHUB_ENV
else
  echo "Diff detected:"
  git diff HEAD "$STORED_FILE" 2>/dev/null || diff <(git show HEAD:"$STORED_FILE") "$STORED_FILE"
  echo "DIFF_FOUND=1" >> $GITHUB_ENV
fi