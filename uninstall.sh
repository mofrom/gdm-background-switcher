#!/bin/bash
#关闭自启
sudo systemctl disable gdm-background-switcher
#删除文件
sudo rm /usr/bin/auto-switcher.sh
sudo rm /usr/bin/archibold
sudo rm /etc/systemd/system/gdm-background-switcher.service
#恢复壁纸
sudo cp sudo cp /usr/share/gnome-shell/gnome-shell-theme.gresource.backup /usr/share/gnome-shell/gnome-shell-theme.gresource
