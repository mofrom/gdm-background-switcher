一个在archlinux上自动更换gdm登录界面背景的脚本

自动选择代码来自[ 黄家垚 / My_Other_Program](http://git.oschina.net/aliendata/My_Other_Program/tree/master/gnome_background_switcher)

程序调用[archibold](http://archiboliod)来更换背景

将jpg格式图片放~/图片/Autowallpaper/目录下，然后执行脚本即可，有多个图片时，程序会自动选取一个作为背景
## 安装方法
首先在`~/图片/`下创建`AutoWallpaper`文件夹，将要更换的背景放到里面，文件名不能为`background.*`然后执行

    git clone https://github.com/coolrc136/gdm-background-switcher.git
    cd gdm-background-switcher
    chmod +x install.sh
    ./install.sh

要自动换壁纸，你需要将脚本设置为登录后自动启动，请先安装aur里的[gnome-session-properties](https://aur.archlinux.org/packages/gnome-session-properties/),然后添加`/usr/bin/auto-switcher.sh`命令即可

程序会在下次开机时更换背景，要更换的背景为`~/图片/background.*`
## 卸载
要卸载脚本，请执行

    chmod +x uninstall.sh
    ./uninstall.sh

如果不想在卸载时恢复背景，请删除uninstall.sh最后一行后执行上面命令
最后在gnome-session-properties删掉命令即可
