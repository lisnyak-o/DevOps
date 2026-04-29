#!/bin/bash

#Created name for file
echo "Введіть назву файла:"
read filename

#Check whether the file exists and have access for read 
if [ -f "$filename" ] && [ -r "$filename" ]; then
	echo "--- Вміст файлу $filename ---"
	cat "$filename"
	echo -e "\n--------------------------"
else
#Check errors
	echo "Помилка: Не вдалося прочитати файл '$filename'." >&2

#Add more info
	if [ ! -e "$filename" ]; then
		echo "Причина: Файл не існує." >&2
	elif [ ! -r "$filename" ]; then
		echo "Причина: Немає прав на читання." >&2
	fi

#Display the result
	exit 1
fi
