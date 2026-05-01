#!/bin/bash
#
#Exercise 7: Command Line Arguments
#Develop a script that accepts a filename as a command line argument and prints the number of lines in that file.

if [[ -z "$1" || ! -f "$1" ]]; then
	echo "Error: need name of file or this file '$1' not find"
	exit 1
fi
#Save result
filename="$1"

#Сount the number
line_count=$(wc -l < "$filename")

#Display result
echo "This is file '$filename' include: $line_count"
