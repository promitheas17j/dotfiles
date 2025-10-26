#!/bin/sh

HIDDEN_DESKTOP=$(bspc query -D -d "" 2>/dev/null)
TMPFILE="/tmp/bspwm_restore_map"

# Get all window IDs currently on the hidden desktop
mapfile -t WINDOWS < <(bspc query -N -d "$HIDDEN_DESKTOP")

if [ ${#WINDOWS[@]} -eq 0 ]; then
	notify-send "Restore" "No minimized windows"
	exit 0
fi

# Build the menu list for Rofi and store ID mapping in temp file
> "$TMPFILE"
MENU=""
for id in "${WINDOWS[@]}"; do
	class=$(xprop -id "$id" WM_CLASS | awk -F '"' '{print $4}')
	title=$(xprop -id "$id" WM_NAME | awk -F '"' '{print $2}')
	entry="${class} — ${title}"
	echo "$entry|$id" >> "$TMPFILE"
	MENU+="${entry}\n"
done

PRIMARY_MONITOR=$(xrandr --query | awk '/ primary/{print $1; exit}')

# Show Rofi menu
CHOSEN=$(echo -e "$MENU" | rofi -dmenu -i -p "Restore window:" \
	-monitor "$PRIMARY_MONITOR" \
	-matching fuzzy \
	-no-custom)

# Exit cleanly if user pressed Escape or nothing selected
if [ -z "$CHOSEN" ]; then
	rm -f "$TMPFILE"
	exit 0
fi

# Extract window ID corresponding to chosen entry
CHOSEN_ID=$(grep -F "$CHOSEN|" "$TMPFILE" | awk -F '|' '{print $2}')

rm -f "$TMPFILE"

CUR_DESKTOP=$(bspc query -D -d focused --names)

# Restore window
if [ -n "$CHOSEN_ID" ]; then
	bspc node "$CHOSEN_ID" --to-desktop "$CUR_DESKTOP"
	bspc node "$CHOSEN_ID" --focus
	# notify-send "Restored" "Window moved to $CUR_DESKTOP"
fi
