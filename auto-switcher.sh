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
  
  IMAGE=$bgfile
  CREATED_TMP="0"
  GST=/usr/share/gnome-shell/gnome-shell-theme.gresource
  GSTRES=$(basename $GST)
  WORKDIR=~/tmp/gdm-login-background
  $r
  if [ "$IMAGE" = "" ]; then
    IMAGE=$(
      dbus-launch gsettings get org.gnome.desktop.screensaver picture-uri |
      sed -e "s/'//g" |
      sed -e "s/^file:\/\///g"
    )
  fi
  if [ ! -f $IMAGE ]; then
    echo "unknown IMAGE $IMAGE"
    exit 1
  fi
  if [ ! -d ~/tmp ]; then
    mkdir -p ~/tmp
    CREATED_TMP="1"
  fi
  mkdir -p $WORKDIR
  cd $WORKDIR
  mkdir -p theme
  for r in `gresource list $GST`; do
    gresource extract $GST $r >$WORKDIR$(echo $r | sed -e 's/^\/org\/gnome\/shell\//\//g')
  done
  cd theme
  \cp -f "$IMAGE" ./background.jpg
  sync
  IMAGE=$(basename $IMAGE)

  cat gnome-shell.css | sed -e 's/#lockDialogGroup/#lockDialogGroup-ignore/g' >gnome-shell.tmp

  echo "
#lockDialogGroup {
  background: #2e3436 url(resource:///org/gnome/shell/theme/${IMAGE});
  background-repeat: no-repeat;
  background-size: cover; }" >>gnome-shell.tmp

  sync
  mv gnome-shell.tmp gnome-shell.css

  echo '<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">' >"${GSTRES}.xml"
  for r in `ls *.*`; do
    echo "    <file>$r</file>" >>"${GSTRES}.xml"
  done
  echo '  </gresource>
</gresources>' >>"${GSTRES}.xml"
  sync
  glib-compile-resources "${GSTRES}.xml"

  sudo mv "/usr/share/gnome-shell/$GSTRES" "/usr/share/gnome-shell/${GSTRES}.backup"
  sudo mv "$GSTRES" /usr/share/gnome-shell/

  rm -r $WORKDIR

  if [ "$CREATED_TMP" = "1" ]; then
    rm -r ~/tmp
  fi
