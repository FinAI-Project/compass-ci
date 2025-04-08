#!/bin/sh

if [ -z "$GITHUB_REPO" ]; then
    echo "Error: GITHUB_REPO is required."
    exit 1
fi

set -e

TOKEN=$(python get-token.py)
REPO_URL="https://x-access-token:$TOKEN@github.com/$GITHUB_REPO.git"
if [ -n "$GITHUB_REF" ]; then
    git clone --branch "$GITHUB_REF" --recurse-submodules "$REPO_URL"
else
    git clone --recurse-submodules "$REPO_URL"
fi

if [ -n "$WORK_DIR" ]; then
    mkdir -p "$WORK_DIR"
    cd "$WORK_DIR"
fi

exec "$@"
