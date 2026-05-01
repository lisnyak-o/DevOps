#!/bin/bash
#
#Exercise 8: Arrays
#Write a script that uses an array to store a list of fruits.
#Loop through the array and print each fruit on a separate line.

#Create array with fruits
fruits=("Mango" "Cherry" "Watermelon" "Pear" "Banana" "Green Apple")

#Print each fruit

for fruit in "${fruits[@]}"; do
	echo -e "You can buy:\n$fruit"
done
