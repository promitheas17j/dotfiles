#!/bin/sh

# rofi -dmenu -i -markup-rows -no-show-icons -theme-str 'window{width: 90%; height: 80%;}'
# Format should be something like this:
# program | keybind | very short name of function | description

KEYBINDS_FILE="/home/mart/.keybinds_list"
SXHKD_CONF="/home/mart/.config/sxhkd/sxhkdrc"
LFRC_CONF="/home/mart/.config/lf/lfrc"

# make sure that we are not duplicating keybinds by appendig to the end of the file on every execution
echo -n > $KEYBINDS_FILE

# Handle and add to the keybinds file the sxhkd bindings
# Find all lines that start with a "#" symbol and print them and the next line
# Exlude all lines that have the pattern "##"
# Store the line that starts with "# " to a variable called text and then search for lines that start with super, then print the message with text variable at the end
# Delete all occurences of the pattern "# "
cat $SXHKD_CONF | grep -A 1 "# " \
	| grep -v '##' \
	| awk '/# / {text = $0} /super/ {print "sxhkd | " $0 " | " text}' \
	| sed 's/# //g' >> $KEYBINDS_FILE


# Handle and add to the keybinds file the lf bindings
# -n suppresses seds default behaviour of printing everything instead making it print only what is requested
# -e indicates that what follows is a sed script
# '/# Keybinds/' tells sed to match lines with "# Keybinds" in them
# :a is a sed label marking a location that sed can jump to
# -e 'n;p;ba' will execute if the pattern is matched. n reads the next line of input to pattern space. p prints the pattern space. ba branches to the label a, restarting the loop
# This results in printing all lines after the line containing "# Keybinds"
# -v inverts the match. -e indicates that what follows is a pattern
# This entire line excludes lines that start with a "#" symbol as well as lines that are empty (^ means the beginning of a line and $ means the end of a line, hence ^$ is an empty line)
# We use printf to format the string we want to print
# $2 refers to the second column
# substr($0, index($0, $5)) takes the entire line and extracts from it the entire line starting from the field $5
# the last line substitutes all occurences of the pattern " #" with nothing, effectively deleting those characters
cat $LFRC_CONF | sed -ne '/# Keybinds/{:a' -e 'n;p;ba' -e '}' \
	| grep  -v -e '^# ' -e '^$' \
	| awk '{ printf "lf | %s | %s\n", $2, substr($0, index($0, $5))  }' \
	| sed -e 's/ #//g' >> $KEYBINDS_FILE
