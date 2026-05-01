#!/bin/bash

#Create dir with full path
WATCH_DIR="/mnt/d/DevOps/Assignments/new_hw5/src/watch"

#Create dir if her haven't
mkdir -p "$WATCH_DIR"

echo "Looking for this folder : $WATCH_DIR"

#Use inotyfiwait for monitoring and take while new file if he create
inotifywait -m -e close_write --format '%f' "$WATCH_DIR" | while read NEW_FILE
do
	#we glue the paths to the file
	FILE_PATH="$WATCH_DIR/$NEW_FILE"
	echo "New file found: $NEW_FILE"
	#Display conten of the file
	cat "$FILE_PATH"
	#Rename file to .back format
	mv "$FILE_PATH" "$FILE_PATH.back"
	echo "File rename : $FILE_PATH.back"
done
