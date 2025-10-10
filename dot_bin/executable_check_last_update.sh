#!/bin/zsh

GREEN='\033[92m'
YELLOW='\033[93m'
RED='\033[91m'
RESET='\033[0m'

# Check if there are available updates for packages
num_packages_to_update=$(yay -Qu | wc -l)
# num_packages_to_update=$(checkupdates | wc -l)

if (( num_packages_to_update >= 0 && num_packages_to_update <= 20 )); then
	echo -e "${GREEN}Available updates: $num_packages_to_update${RESET}" >> /dev/tty
elif (( num_packages_to_update > 20 && num_packages_to_update <= 50 )); then
	echo -e "${YELLOW}Available updates: $num_packages_to_update${RESET}" >> /dev/tty
else
	echo -e "${RED}Available updates: $num_packages_to_update${RESET}" >> /dev/tty
fi

# Kernel version check
running_kernel=$(uname -r)
installed_kernel=$(pacman -Q linux | awk '{print $2}' | cut -d '-' -f1 | cut -d '.' -f1,2,3)

running_kernel_base=$(echo "$running_kernel" | cut -d '-' -f1)

if [[ "$running_kernel_base" != "$installed_kernel" ]];
then
	echo -e "${RED}Kernel mismatch detected. Reboot recommended.${RESET}" >> /dev/tty
fi
