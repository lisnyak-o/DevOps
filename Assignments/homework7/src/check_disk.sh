#!/bin/bash
#
#Напишіть сценарій і налаштуйте crontab для запуску цього сценарію,
#який перевірятиме використання вашого обсягу /,
#і якщо воно перевищує X відсотків (налаштовується в crontab),
#він записуватиме попереджувальне повідомлення у файл журналу /var/log/disk.log
#Create variable for log file & default threshold if empty = 80%
THRESHOLD=${1:-80}
LOG_FILE="/var/log/disk.log"

#Check "df /" use pipe for take "%Use" and make is  clear number "without %"
CURRENT_USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

#
if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
	#Here, write data and current usage
	MESSAGE="$(date '+%Y-%m-%d %H:%M:%S') - WARNING: Disk usage is at ${CURRENT_USAGE}% (Threshold: ${THRESHOLD}%)"
        echo "$MESSAGE" >> "$LOG_FILE"
fi
