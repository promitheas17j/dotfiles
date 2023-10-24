#!/bin/zsh
#
# SCRIPT DOES NOT WORK
#

TEMP_HISTFILE=~/temp_history
fc -l -10000 > $TEMP_HISTFILE

{cat $TEMP_HISTFILE | grep -e 'pacman -S\s' -e 'pacman -R\s' -e 'yay -S\s' -e 'yay -R\s' $TEMP_HISTFILE | tail -n 50} > ~/history_installed

rm $TEMP_HISTFILE
