#!/bin/zsh

datetime=$(date '+%d_%m_%Y_%H_%M_%S')

echo "STOP RECORDING WITH DOUBLE q. LEAVE A COUPLE SECONDS INBETWEEN KEYPRESSES"
read "export_gif?Would you like to also export recording as a gif? [yY/nN]"

ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 ~/Pictures/ScreenRecordings/${datetime}_recording.mp4

echo " "
echo " "
echo " "
echo " "

if [[ "$export_gif" == 'y' || export_gif == 'Y' ]];
then
	echo "Exporting..."
	ffmpeg -i ~/Pictures/ScreenRecordings/${datetime}_recording.mp4 ${datetime}_recording.gif
else
	if [[ "$export_gif" == 'n' || export_gif == 'N' ]];
	then
		echo "Doing nothing..."
	else
		echo "Failed: You must enter either 'y', 'Y', 'n', or 'N'."
	fi
fi
