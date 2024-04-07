#!/bin/sh

# rofi -dmenu -i -markup-rows -no-show-icons -theme-str 'window{width: 90%; height: 80%;}'
# Format should be something like this:
# program | keybind | very short name of function | description

KEYBINDS_FILE="/home/mart/.keybinds_list"
SXHKD_CONF="/home/mart/.config/sxhkd/sxhkdrc"

# make sure that we are not duplicating keybinds by appendig to the end of the file on every execution
echo -n > $KEYBINDS_FILE

# Handle and add to the keybinds file the sxhkd bindings
cat $SXHKD_CONF | grep -A 1 "# " | grep -v "comment" | grep -v "##" | awk '/# / {text = $0} /super/ {print "sxhkd | " $0 " | " text}' | sed 's/# //g' >> $KEYBINDS_FILE

