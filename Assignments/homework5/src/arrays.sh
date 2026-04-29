#!/bin/bash

#Create array

fruits=("Apple" "Green Banana" "Cherry" "Date" "Elderberry")

#Add info
echo "Мій список фруктів:"
echo "-------------------"

#Loop for iterating through array elements
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

echo "Всього: ${#fruits[@]}"
