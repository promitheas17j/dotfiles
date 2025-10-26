#!/bin/sh

HIDDEN_DESKTOP=$(bspc query -D -d "" 2>/dev/null)

WIN_ID=$(bspc query -N -n focused)

if [ -n "$WIN_ID" ]; then
	bspc node "$WIN_ID" --to-desktop "$HIDDEN_DESKTOP"
	# notify-send "Minimised" "Window moved to hidden workspace"
fi
