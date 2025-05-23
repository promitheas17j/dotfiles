#!/bin/zsh

last_upgrade_date=$(grep -m 1 'full system upgrade' /var/log/pacman.log | cut -d ' ' -f 1 | tr -d '[]')
last_upgrade_sec=$(date --date="$last_upgrade_date" +%s) # Convert to UNIX timestamp

last_upgrade_sec=$(date -d "$last_upgrade_date" +%s)
now_sec=$(date +%s)

days_since=$(( (now_sec - last_upgrade_sec) / 86400 ))

if (( days_since > 3 )); then
	echo "Days since last update: $days_since day(s)" >> /dev/tty
fi

# Kernel version check
running_kernel=$(uname -r)
installed_kernel=$(pacman -Q linux | awk '{print $2}' | cut -d '-' -f1 | cut -d '.' -f1,2,3)

running_kernel_base=$(echo "$running_kernel" | cut -d '-' -f1)

if [[ "$running_kernel_base" != "$installed_kernel" ]];
then
	echo "Kernel mismatch detected. Reboot recommended." >> /dev/tty
fi
