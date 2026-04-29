#!/bin/bash

#Check if a file exists

filename="name_user.sh"

if [ -f $filename ]; then
    echo "The file exists"
else
    echo "The file does not exists"
fi
