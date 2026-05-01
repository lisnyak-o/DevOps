#!/bin/bash
#
#Exercise 3: Conditional Statements
#Write a script that checks if a file exists in the current directory.
#If it does, print a message saying it exists; otherwise, print a message saying it doesn't exist.

filename=(example.*)
if [[ -f "$filename" ]]; then
	echo "This ${filename[*]} exists in the current directory"
else
	echo "This ${filename[*]} doesn't exists"

fi
exit 0
