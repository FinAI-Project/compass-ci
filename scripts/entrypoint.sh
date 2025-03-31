#!/bin/sh

if [ -z "$GITHUB_REPO_NAME" ]; then
    echo "Error: GITHUB_REPO_NAME is required."
    exit 1
fi

set -e

TOKEN=$(python get-token.py)
GITHUB_REPO_OWNER=${GITHUB_REPO_OWNER:-FinAI-Project}
REPO_URL="https://x-access-token:$TOKEN@github.com/$GITHUB_REPO_OWNER/$GITHUB_REPO_NAME.git"
if [ -n "$GITHUB_REF_NAME" ]; then
    git clone --branch "$GITHUB_REF_NAME" --recurse-submodules "$REPO_URL" model
else
    git clone --recurse-submodules "$REPO_URL" model
fi

if [ -n "$WORK_DIR" ]; then
    mkdir -p "$WORK_DIR"
    cd "$WORK_DIR"
fi

exec "$@"