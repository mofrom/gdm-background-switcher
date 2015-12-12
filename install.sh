#!/bin/bash
################################
export DISPLAY=:0
rm ${HOME}/图片/AutoWallpaper/background.*
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
	bkfile=$(cat ${HOME}/图片/AutoWallpaper/.background.txt)
 	echo "old_wallpaper: $bkfile"
	echo "new_wallpaper: $bgfile"

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
echo "$bgfile" > ${HOME}/图片/AutoWallpaper/.background.txt
echo "#!/bin/bash" > gdm-switcher.sh
echo "themefile="${HOME}/图片/AutoWallpaper/gresource"" >> gdm-switcher.sh
chmod +x gdm-switcher.sh
echo "mv "${HOME}/图片/AutoWallpaper/gnome-shell-theme.gresource" "/usr/share/gnome-shell/gnome-shell-theme.gresource"" >> gdm-switcher.sh
sudo cp /usr/share/gnome-shell/gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource.backup
cat > gdm-background-switcher.service <<- EOF
[Unit]
Description=gdm-background-switcher
Before=gdm.service
[Service]
ExecStart=/root/gdm-switcher.sh
[Install]
WantedBy=multi-user.target
EOF
chmod +x archibold
sudo cp archibold /usr/bin/
sudo cp gdm-background-switcher.service /etc/systemd/system/
sudo cp gdm-switcher.sh /root/
sudo systemctl daemon-reload
sudo systemctl enable gdm-background-switcher
sudo cp auto-switcher.sh /usr/bin/
