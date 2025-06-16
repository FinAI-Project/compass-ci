#!/bin/bash

if [ -z "$GITHUB_REPO" ]; then
    echo "Error: GITHUB_REPO is required."
    exit 1
fi

TOKEN=$(python get-token.py) || {
    echo "get token failed: $TOKEN"
    exit 1
}

set -e

REPO_URL="https://x-access-token:$TOKEN@github.com/$GITHUB_REPO.git"
if [ -n "$GITHUB_REF" ]; then
    git clone --branch "$GITHUB_REF" --recurse-submodules "$REPO_URL"
else
    git clone --recurse-submodules "$REPO_URL"
fi

set +e

mkdir -p /tmp/runner
cd /tmp/runner
if [ -n "$OUTPUT_DIR" ] && [ -d "$OUTPUT_DIR" ]; then
    rsync -rltv "$OUTPUT_DIR/" .
fi
"$@"
EXIT_CODE=$?
echo -n $EXIT_CODE > /tmp/runner/done

if [ -n "$WORK_DIR" ] && [[ "$WORK_DIR" == /output/* ]]; then
    mkdir -p "$WORK_DIR"
    cp -R --preserve=timestamps . "$WORK_DIR"
fi

exit $EXIT_CODE