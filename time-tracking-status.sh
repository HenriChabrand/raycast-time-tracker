#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Time Tracker
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 30s

# Optional parameters:
# @raycast.icon 👨‍💻
# @raycast.packageName Time Tracker

# Documentation:
# @raycast.description Status of current tracked task
# @raycast.author Henri Chabrand
# @raycast.authorURL https://www.linkedin.com/in/henri-chabrand--product-manager/


# Check if tracking has started
if [ ! -f "$TMPDIR/raycast-time-tracker-start.txt" ]; then
    echo "No tracking started" 
fi

# Compute time elapsed since the start
NOW=$(date +"%s")
START=$(<"$TMPDIR/raycast-time-tracker-start.txt")
DIFF=$((NOW - START))


# Retrieve current task name
if [ -f "$TMPDIR/raycast-time-tracker-name.txt" ]; then
	TASK_NAME=$(<"$TMPDIR/raycast-time-tracker-name.txt")
fi


# Inline display tiem elapsed and current task name
if [ $DIFF -lt 60 ]; then
    export TERM=linux; echo "$(tput setaf 3) 0 min $(tput sgr0)spent on $(tput setaf 4)$TASK_NAME$(tput sgr0)";
elif [ $DIFF -lt 3600 ]; then
    export TERM=linux; echo "$(tput setaf 3) $((DIFF%3600/60)) min $(tput sgr0)spent on $(tput setaf 4)$TASK_NAME$(tput sgr0)";
   
else
    export TERM=linux; echo "$(tput setaf 3) $((DIFF/3600)) h $((DIFF%3600/60)) min $(tput sgr0)spent on $(tput setaf 4)$TASK_NAME$(tput sgr0)";
fi


