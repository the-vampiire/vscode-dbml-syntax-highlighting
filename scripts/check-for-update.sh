#!/bin/bash

URL="https://raw.githubusercontent.com/holistics/dbml/master/dbml-playground/src/components/monaco/dbml-language.ts"
STORED_FILE="source/dbml-language.ts"
DIFF_FILE="source/diff-output.txt"

# Fetch latest source and overwrite stored file
curl -s "$URL" -o "$STORED_FILE"

# Check for diffs using git (assumes git repo is initialized and STORED_FILE is committed)
if git diff --quiet HEAD "$STORED_FILE" 2>/dev/null; then
  echo "No changes detected."
  exit 0
else
  git diff HEAD "$STORED_FILE" > "$DIFF_FILE" 2>/dev/null || diff <(git show HEAD:"$STORED_FILE") "$STORED_FILE" > "$DIFF_FILE"
  echo "Diff stored in $DIFF_FILE"
  exit 1
fi