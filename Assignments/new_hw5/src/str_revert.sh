#!/bin/bash
#
#Exercise 6: String Manipulation
#Build a script that takes a user's input as a sentence
#and then reverses the sentence word by word (e.g., "Hello World" becomes "World Hello").

read -p "Enter the sentence (example: 'Oleg'): " input_str

#Change string to array
words=($input_str)

#Read how many words in array
num_words=${#words[@]}

#Create new empty variable for result
revert_str=""

#Use cycle for check elements in array and write revert to empty variable
for (( i=$num_words-1; i>=0; i-- )); do
	revert_str="$revert_str ${words[$i]}"
done

echo "Result: $revert_str"
