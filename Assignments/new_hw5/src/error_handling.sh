#!/bin/bash
#
#Exercise 9: Error Handling
#Develop a script that attempts to read a file and handles errors gracefully.
#If the file exists, it should print its contents; if not, it should display an error message.

read -p "Write name of the file: " filename
if [[ -f "$filename" && ! -z "$filename" ]]; then
	echo "Display content of this file: "
	cat "$filename"
else
	echo "Error: File don't exists or he is empty"
   if [[ -r "$filename" ]]; then
	echo "Error: Permission denied"
   fi
 exit 1
fi
