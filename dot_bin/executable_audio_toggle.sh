#!/bin/sh

SINK=$(pactl get-default-sink)

# Extract current active port
ACTIVE_PORT=$(pactl list sinks | awk -v sink="$SINK" '
	$0 ~ "Name: "sink {found=1}
	found && /Active Port:/ {print $3; exit}')

# Define your ports (adjust names if needed)
HEADPHONES="analog-output-headphones"
LINEOUT="analog-output-lineout"

case "$1" in
	toggle)
		if [[ "$ACTIVE_PORT" == "$HEADPHONES" ]]; then
			pactl set-sink-port "$SINK" "$LINEOUT"
			notify-send "Audio Output" "Switched to Line Out (Speakers)"
		else
			pactl set-sink-port "$SINK" "$HEADPHONES"
			notify-send "Audio Output" "Switched to Headphones"
		fi
		;;
	*)
		# Just show icon for Polybar (no toggling)
		if [[ "$ACTIVE_PORT" == "$HEADPHONES" ]]; then
			echo ""
		else
			echo ""
		fi
		;;
esac
