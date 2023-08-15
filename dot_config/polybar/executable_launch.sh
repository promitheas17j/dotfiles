#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch bar
# polybar bottom -c ~/.config/polybar/config-single &
if [[ $(xrandr -q | grep "HDMI-A-1 connected") ]]; # Second monitor detected - launch both bars with dual monitor config
then
	polybar top -c ~/.config/polybar/config-dual &
	polybar bottom -c ~/.config/polybar/config-dual &
else # Second monitor not detected - launch only bottom bar with single monitor config
	polybar bottom -c ~/.config/polybar/config-single &
fi
