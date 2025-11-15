#!/usr/bin/sh
set -eu

get_default_sink() {
	pactl get-default-sink 2>/dev/null || true
}

read_sinks() {
	pactl list short sinks 2>/dev/null | awk '{print $2}'
}

choose_sink_by_regex() {
	local regex="$1"
	awk -v r="$regex" 'BEGIN{IGNORECASE=1} $0 ~ r {print; exit}'
}

get_best_port_for_sink() {
	local sink="$1"
	pactl list sinks | awk -v sink="$sink" '
		$0 ~ "Name: " sink {inblock=1}
		inblock && /Active Port:/ {
			gsub(/^[ \t]*Active Port:[ \t]*/, "", $0)
			print $0
			exit
		}
		inblock && /^Ports:/ {ports=1; next}
		ports && /^[ \t]*[^ \t]/ {
			# port line like "analog-output-headphones: Headphones (priority 9900, available: yes)"
			pname=$1
			sub(/:$/, "", pname)
			# next token/line could contain "available: yes"
			print pname
			exit
		}
	'
}

set_sink_port_if_present() {
	local sink="$1" port="$2"
	if [ -n "$port" ]; then
		pactl set-sink-port "$sink" "$port" 2>/dev/null || true
	fi
}

DEFAULT_SINK="$(get_default_sink)"
ALL_SINKS="$(read_sinks || true)"

if [ -z "${ALL_SINKS:-}" ]; then
	case "${1:-}" in
		toggle) notify-send "Audio Output" "No sinks found"; exit 0 ;;
		*) echo ""; exit 0 ;;
	esac
fi

HEADSET_SINK="$(printf '%s\n' "$ALL_SINKS" | choose_sink_by_regex 'usb|headset|bluetooth' || true)"
SPEAKERS_SINK="$(printf '%s\n' "$ALL_SINKS" | awk 'BEGIN{IGNORECASE=1} $0 !~ /usb|hdmi|bluetooth/ && $0 ~ /analog|pci|alsa/ {print; exit}')"

if [ -z "$SPEAKERS_SINK" ]; then
	if [ -n "$HEADSET_SINK" ]; then
		SPEAKERS_SINK="$(printf '%s\n' "$ALL_SINKS" | awk -v h="$HEADSET_SINK" '$0 != h {print; exit}')"
	else
		SPEAKERS_SINK="$(printf '%s\n' "$ALL_SINKS" | head -n1)"
	fi
fi

if [ -z "$HEADSET_SINK" ]; then
	HEADSET_SINK="$(printf '%s\n' "$ALL_SINKS" | grep -i usb || true)"
fi

HEADSET_PORT=""
SPEAKERS_PORT=""
if [ -n "$HEADSET_SINK" ]; then
	HEADSET_PORT="$(get_best_port_for_sink "$HEADSET_SINK" || true)"
fi
if [ -n "$SPEAKERS_SINK" ]; then
	SPEAKERS_PORT="$(get_best_port_for_sink "$SPEAKERS_SINK" || true)"
fi

case "${1:-}" in
	toggle)
		if [ -n "$HEADSET_SINK" ] && [ "$DEFAULT_SINK" = "$HEADSET_SINK" ]; then
			pactl set-default-sink "$SPEAKERS_SINK"
			set_sink_port_if_present "$SPEAKERS_SINK" "$SPEAKERS_PORT"
			notify-send "Audio Output" "Switched to Speakers"
		else
			if [ -n "$HEADSET_SINK" ]; then
				pactl set-default-sink "$HEADSET_SINK"
				set_sink_port_if_present "$HEADSET_SINK" "$HEADSET_PORT"
				notify-send "Audio Output" "Switched to Headset"
			else
				pactl set-default-sink "$SPEAKERS_SINK"
				set_sink_port_if_present "$SPEAKERS_SINK" "$SPEAKERS_PORT"
				notify-send "Audio Output" "Switched to Speakers"
			fi
		fi
		;;
	*)
		if [ -n "$HEADSET_SINK" ] && [ "$DEFAULT_SINK" = "$HEADSET_SINK" ]; then
			echo ""
		else
			echo ""
		fi
		;;
esac
