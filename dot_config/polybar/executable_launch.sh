#!/bin/sh

# Terminate already running bar instances
pgrep -x polybar | xargs kill

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Make sure that all monitors have been detected by OS before checking how many bars to launch
sleep 3

connected_monitors=$(xrandr --listmonitors | grep -c ' connected')

# Launch bar
if [[ "$connected_monitors" -gt 1 ]]; # Second monitor detected - launch both bars with dual monitor config
then
	# Multi-monitor setup
	polybar top -c ~/.config/polybar/config-dual &
	polybar bottom -c ~/.config/polybar/config-dual &
else
	# Single monitor setup
	polybar bottom -c ~/.config/polybar/config-single &
fi
