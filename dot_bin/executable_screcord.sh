#!/bin/zsh
# https://github.com/ropery/FFcast/tree/master

datetime=$(date '+%d_%m_%Y_%H_%M_%S')
srdir=/home/mart/Pictures/ScreenRecordings

read "export_gif?Would you like to also export recording as a gif? [yY/nN]"
echo "Run pkill -fxn '(/\S+)*ffmpeg\s.*\sx11grab\s.*' to stop recording"

echo " "
echo " "
echo " "
echo " "

if [[ "$export_gif" == 'y' || export_gif == 'Y' ]];
then
	ffcast -svv rec	${srdir}/${datetime}_recording.mp4 && ffmpeg -i ${srdir}/${datetime}_recording.mp4 ${srdir}/${datetime}_recording.gif
	# ffcast -svv rec	~/Pictures/ScreenRecordings/${datetime}_recording.mp4 && ffmpeg -i ~/Pictures/ScreenRecordings/${datetime}_recording.mp4 ${datetime}_recording.gif
	# ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 ~/Pictures/ScreenRecordings/${datetime}_recording.mp4 & ffmpeg -i ~/Pictures/ScreenRecordings/${datetime}_recording.mp4 ${datetime}_recording.gif
else
	if [[ "$export_gif" == 'n' || export_gif == 'N' ]];
	then
		ffcast -svv rec	${srdir}/${datetime}_recording.mp4
	else
		echo "Failed: You must enter either 'y', 'Y', 'n', or 'N'."
	fi
fi
