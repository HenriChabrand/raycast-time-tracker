#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Tracking
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👨‍💻
# @raycast.argument1 { "type": "text", "placeholder": "Rename Task", "optional": true}
# @raycast.packageName Time Tracker

# Documentation:
# @raycast.description Stop and send current tracked task
# @raycast.author Henri Chabrand
# @raycast.authorURL https://www.linkedin.com/in/henri-chabrand--product-manager/



# TODO Set the webhook URL
# URL=https://hookbin.com/Z2rJawdmBJiK6bmm6BmW

# You will receive the following variables:
# name         name of the task
# start_at     timestamp of the tracking start
# end_at       timestamp of the tracking end
# duration     seconds elapsed betwen the start and end
# duration_h   human readable elapsed time betwen the start and end



# Check if tracking has started
if [ ! -f "$TMPDIR/raycast-time-tracker-start.txt" ]; then
    echo "No tracking started" 
    exit 1
fi

# Compute time elapsed since the start
NOW=$(date +"%s")
START=$(<"$TMPDIR/raycast-time-tracker-start.txt")
DIFF=$((NOW - START))

# Retrieve current task name OR rename it
if [ -n "$1" ]; then
  TASK_NAME="$1"
else
  if [ -f "$TMPDIR/raycast-time-tracker-name.txt" ]; then
	TASK_NAME=$(<"$TMPDIR/raycast-time-tracker-name.txt")
	else
	TASK_NAME="Some Task"
  fi
fi


# Display tiem elapsed for the current task
if [ $DIFF -lt 60 ]; then
    echo "$TASK_NAME stoped after 0 min";
elif [ $DIFF -lt 3600 ]; then
    echo "$TASK_NAME stoped after $((DIFF%3600/60)) min";
   
else
    echo "$TASK_NAME stoped after $((DIFF/3600)) h $((DIFF%3600/60)) min";
fi


# Copy task name and time to clipboard
pbcopy <<< "$TASK_NAME : $((DIFF/3600))h $((DIFF%3600/60))m"


# Send task tracked to webhook URL
if [ $URL ]; then
    curl -X POST -H "Content-Type: application/json" -d '{"name":"'"$TASK_NAME"'", "start_at":'$((START*1000))', "end_at":'$((NOW*1000))', "duration":'$DIFF'}' $URL  -s -S > /dev/null
fi

# Remove current task name and start time
rm "$TMPDIR/raycast-time-tracker-start.txt"
rm "$TMPDIR/raycast-time-tracker-name.txt"