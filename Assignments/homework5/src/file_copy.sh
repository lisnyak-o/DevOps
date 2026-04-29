#!/bin/bash

# Copy file from one location to another (from dir /lis/bash_scripts to dir homework5/src)
source_dir="/home/lis/bash_scripts"
copy_dir="/mnt/d/DevOps/Assignments/homework5/src"
#Perform the copy dir using the 'cp' command
cp -r $source_dir $copy_dir
# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Files copied successfully."
else
  echo "Copied failed. Please check the source and destination directories."
fi
