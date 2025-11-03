#!/usr/bin/env sh

STATE_FILE="/tmp/polybar_temp_state"

# Initialize if not exists
if [ ! -f "$STATE_FILE" ]; then
	echo "basic" > "$STATE_FILE"
fi

# Toggle mode if clicked
if [ "$1" = "toggle" ]; then
	if grep -q "basic" "$STATE_FILE"; then
		echo "detailed" > "$STATE_FILE"
	else
		echo "basic" > "$STATE_FILE"
	fi
	exit 0
fi

MODE=$(cat "$STATE_FILE")
SENSORS_OUTPUT=$(sensors 2>/dev/null)

# ------------------------
# Helper: safely extract numeric value
# ------------------------
extract_first_temp() {
	echo "$1" | grep -Eo '\+[0-9]+(\.[0-9]+)?°C' | head -n1 | tr -d '+°C'
}

CPU_TEMP=$(echo "$SENSORS_OUTPUT" | awk '/Tctl:/ {print $2; exit}/Package id 0:/{print $4; exit}/Core 0:/{print $3; exit}' | tr -d '+°C')
[ -z "$CPU_TEMP" ] && CPU_TEMP=$(extract_first_temp "$(echo "$SENSORS_OUTPUT" | grep -A1 -Ei 'cpu|k10temp|coretemp')")

GPU_TEMP=$(echo "$SENSORS_OUTPUT" | awk '/^amdgpu-pci-/{flag=1; next} /^$/{flag=0} flag && /edge:/ {gsub(/\+|°C/,"",$2); print $2; exit}')
[ -z "$GPU_TEMP" ] && GPU_TEMP=$(echo "$SENSORS_OUTPUT" | awk '/^nouveau-pci-/{flag=1; next} /^$/{flag=0} flag && /temp1:/ {gsub(/\+|°C/,"",$2); print $2; exit}')
[ -z "$GPU_TEMP" ] && GPU_TEMP=$(echo "$SENSORS_OUTPUT" | awk '/^nvidia-/{flag=1; next} /^$/{flag=0} flag && /temp1:/ {gsub(/\+|°C/,"",$2); print $2; exit}')

RAM_TEMP=$(echo "$SENSORS_OUTPUT" | awk '/DDR|DIMM|memory|ram|DRAM/ {gsub(/\+|°C/,"",$2); print $2; exit}')
[ -z "$RAM_TEMP" ] && RAM_TEMP=$(extract_first_temp "$(echo "$SENSORS_OUTPUT" | grep -A1 -Ei 'dimm|ddr|ram|memory')")

SSD_TEMP=$(echo "$SENSORS_OUTPUT" | awk '/Composite:/ {gsub(/\+|°C/,"",$2); print $2; exit}')
[ -z "$SSD_TEMP" ] && SSD_TEMP=$(extract_first_temp "$(echo "$SENSORS_OUTPUT" | grep -A1 -Ei 'nvme|drive|hddtemp')")

colorize() {
	local temp="$1"
	local type="$2"
	if [ -z "$temp" ] || ! echo "$temp" | grep -Eq '^[0-9]+(\.[0-9]+)?$'; then
		echo "%{F#888888}N/A%{F-}"
		return
	fi
	case "$type" in
		cpu)
			cool=35; warm=85 ;;
		gpu)
			cool=45; warm=90 ;;
		ssd|nvme)
			cool=45; warm=81 ;;
		ram)
			cool=45; warm=65 ;;
		*)
			cool=60; warm=80 ;;  # fallback
	esac
	if (( $(echo "$temp < $cool" | bc -l) )); then
		echo "%{F#00FF00}${temp}°C%{F-}"   # green
	elif (( $(echo "$temp < $warm" | bc -l) )); then
		echo "%{F#FFFF00}${temp}°C%{F-}"   # yellow
	else
		echo "%{F#FF0000}${temp}°C%{F-}"   # red
	fi
}

CPU_OUT=$(colorize "$CPU_TEMP" "cpu")
GPU_OUT=$(colorize "$GPU_TEMP" "gpu")
RAM_OUT=$(colorize "$RAM_TEMP" "ram")
SSD_OUT=$(colorize "$SSD_TEMP" "nvme")

if [ "$MODE" = "basic" ]; then
	printf "CPU:%s" "$CPU_OUT"
else
	printf "CPU:%s " "$CPU_OUT"
	[ -n "$GPU_TEMP" ] && printf "GPU:%s " "$GPU_OUT"
	[ -n "$RAM_TEMP" ] && printf "RAM:%s " "$RAM_OUT"
	[ -n "$SSD_TEMP" ] && printf "SSD:%s" "$SSD_OUT"
	echo
fi
