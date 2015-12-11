#!/bin/bash
################################
export DISPLAY=:0
confFile="/tmp/.switchbg.conf"
BGDIR="${HOME}/图片/AutoWallpaper/"
filepath=${BGDIR}

find $filepath | grep -i -E ".jpg$|.png$|.jpeg$|.bmp$" > $confFile
cnt=`cat $confFile | wc -l`

while true
do
	line=$(($RANDOM % $cnt + 1))
	bgfile=$(head -n $line $confFile | tail -n 1)
	bgfile="$bgfile"
	bkfile=$(gsettings get org.gnome.desktop.background picture-uri)
#	echo "old_wallpaper: $bkfile"
#	echo "new_wallpaper: $bgfile"

	if [[ ( ${cnt} == 1 ) && ( $bkfile == $bgfile ) ]]; then
		break
	fi
	if [[ $bkfile != $bgfile ]]; then
		break
	fi
done
################################
ssa="${bgfile##*.}"
cp $bgfile ~/图片/AutoWallpaper/background.$ssa

./archibold login-background ~/图片/AutoWallpaper/background.$ssa
