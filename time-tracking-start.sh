#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Tracking
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👨‍💻
# @raycast.argument1 { "type": "text", "placeholder": "Task Name"}
# @raycast.packageName Time Tracker

# Documentation:
# @raycast.description Start tracking new task
# @raycast.author Henri Chabrand
# @raycast.authorURL https://www.linkedin.com/in/henri-chabrand--product-manager/


if [ -f "$TMPDIR/raycast-time-tracker-start.txt" ]; then
    echo "A stopwatch already exists!" > /dev/stderr
    exit 1
fi



if [ -n "$1" ]; then
  TASK_NAME="$1"
else
  TASK_NAME="Some Task"
fi

date +"%s" > "$TMPDIR/raycast-time-tracker-start.txt"

echo "$TASK_NAME" > "$TMPDIR/raycast-time-tracker-name.txt"

echo "$TASK_NAME started!"