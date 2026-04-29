#!/bin/bash

#Path for watch_dir
WATCH_DIR="$HOME/watch"

#Create folder for watching
mkdir -p "$WATCH_DIR"

echo "Каталог переглядів: $WATCH_DIR"

#Start cycle of watching
inotifywait -m -e create --format '%f' "$WATCH_DIR" | while read NEW_FILE
do
	#Full path to file
	FILE_PATH="$WATCH_DIR/$NEW_FILE"
	#Give the file some time (0.1s) to be completely written
	sleep 0.1

	echo "--- Новий файл найдено: $NEW_FILE ---"
	cat "$FILE_PATH"
	echo -e "\n--- Завершення ---"

#Rename to .back
 mv "$FILE_PATH" "$FILE_PATH.back"
	echo "Переіменовано в $NEW_FILE.back"
done
