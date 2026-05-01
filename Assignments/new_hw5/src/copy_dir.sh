#!/bin/bash
#
#Exercise 5: File Operations
#Write a script that copies a file from one location to another. Both localtions should be passed as arguments

#Declare variables
copy_dir=/home/lis/devops/test

current_dir=/mnt/d/DevOps/Assignments/new_hw5/src/

echo "Coping files from source_dir to current..."
cp -r $copy_dir $current_dir
if [[ $? -eq 0 ]]; then
	echo "Finished, current_dir have new files."
else
	echo "ERROR: Try again"
fi
