#!/bin/bash

WORK_DIR="/tmp/runner"
while true; do
    if [ -f "$WORK_DIR/done" ]; then
        rsync -rlt --delete "$WORK_DIR/" "$OUTPUT_DIR"
        exit 0
    fi

    minute=$(date +'%M')
    if [ $((minute % 3)) -eq 0 ]; then
        rsync -rlt --delete "$WORK_DIR/" "$OUTPUT_DIR"
    fi

    sleep 60
done