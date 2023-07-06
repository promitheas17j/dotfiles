#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch bar
polybar bottom &

if [[ $(xrandr -q | grep "HDMI-A-1 connected") ]];
then
	polybar top &
fi
