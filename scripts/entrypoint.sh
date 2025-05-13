#!/bin/sh

if [ -z "$GITHUB_REPO" ]; then
    echo "Error: GITHUB_REPO is required."
    exit 1
fi

TOKEN=$(python get-token.py) || {
    echo "get token failed: $TOKEN"
    exit $?
}

set -e

REPO_URL="https://x-access-token:$TOKEN@github.com/$GITHUB_REPO.git"
if [ -n "$GITHUB_REF" ]; then
    git clone --branch "$GITHUB_REF" --recurse-submodules "$REPO_URL"
else
    git clone --recurse-submodules "$REPO_URL"
fi

set +e

cd "$(mktemp -d)"
"$@"
RETURN_CODE=$?

if [ -n "$WORK_DIR" ]; then
    mkdir -p "$WORK_DIR"
    cp -R --preserve=timestamps . "$WORK_DIR"
fi

exit $RETURN_CODE