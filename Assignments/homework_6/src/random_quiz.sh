#!/bin/bash
#Description
#Сценарій генерує випадкове число від 1 до 100 і зберігає його в змінній.
#Користувачеві пропонується вгадати число.
#Якщо припущення користувача правильне, сценарій має надрукувати «Вітаємо! Ви вгадали правильне число». і вихід.
#Якщо припущення користувача неправильне, сценарій має надати зворотний зв’язок,
#як-от «Занадто високо» або «Занадто низько», і дозволити користувачеві вгадати ще раз.
#Користувач повинен мати максимум 5 спроб, щоб вгадати правильне число.
#Після 5 невдалих спроб сценарій має надрукувати «Вибачте, у вас закінчилися спроби.
#Правильним числом було [правильний номер]» і завершити роботу.


# Create random number (RANDOM % (MAX - MIN + 1)) + MIN
RANDOM_NUM=$(( RANDOM % 100 + 1 ))
# Create variable with 5 attemps for user
ATTEMPS=5
echo -e "Лотерея запущена...\nВгадайте число від 1 до 100"

#Use loop for check attemps
for (( i=1; i<=$ATTEMPS; i++ )); do
    read -p "Ваша спроба $i із $ATTEMPS. Введіть Ваше число: " INPUT_NUM
     #Create checking input number user`s and print hints or
     #congratulation user and finishe script
     if [[ $INPUT_NUM -eq $RANDOM_NUM ]]; then
          echo "Вітаємо! Ви вгадали правильне число"
	  exit 0
     elif [[ $INPUT_NUM -gt $RANDOM_NUM ]]; then
            echo "Занадто високо"
     else
            echo "Занадто низько"
     fi
done
#If user try all apptemps, print this hint
echo "Вибачте, у вас закінчилися спроби. Правильним числом було $RANDOM_NUM"
