#!/bin/bash

#Запитуємо ввід у користувача
echo "Введіть речення:"
read input_sentence

#Перетворюємо рядок у масив
words=($input_sentence)

#Визначаємо кількість слів у масиві
num_words=${#words[@]}

#Створюємо порожню змінну для результату
reversed_sentence=""

#Цикл від останнього елемента до першого
for (( i=$num_words-1; i>=0; i-- )); do
    reversed_sentence="$reversed_sentence ${words[$i]}"
done

#Виводимо результат
echo "Результат:"
echo $reversed_sentence
