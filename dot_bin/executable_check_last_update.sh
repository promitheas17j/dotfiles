#!/bin/zsh

last_upgrade=$(grep -m 1 'full system upgrade' /var/log/pacman.log | cut -d ' ' -f 1 | tr -d '[]')

last_upgrade_sec=$(date -d "$last_upgrade_date" +%s)
now_sec=$(date +%s)

days_since=$(( (now_sec - last_upgrade_sec) / 86400 ))

if (( days_since > 3 )); then
	echo "Days since last update: $days_since day(s)"
fi
