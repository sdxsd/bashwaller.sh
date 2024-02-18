#!/usr/bin/env bash

XFWM="Xfwm4"
GNOME="GNOME"
DARWIN="Darwin"
KDE="KWin"
FULL_PATH=""

change_wallpaper_KDE () {
	plasma-apply-wallpaperimage $FULL_PATH
}

# GNOME
change_wallpaper_GNOME () {
	gsettings set org.gnome.desktop.background picture-uri file://$FULL_PATH
	gsettings set org.gnome.desktop.background picture-uri-dark file://$FULL_PATH
}

# XFCE4
change_wallpaper_Xfwm4 () {
	LIST=($(xfconf-query -c xfce4-desktop -l | \
		grep "monitor" | grep "last-image"))
	for MONITOR in "${LIST[@]}"
	do
		xfconf-query -c xfce4-desktop -p $MONITOR -s $FULL_PATH
	done
}

# MacOS
change_wallpaper_aqua () {
	CMD="'tell application \"Finder\" to set desktop picture to POSIX file \"$FULL_PATH\"'"
	zsh -c "osascript -e $CMD"
}

determine_wm_and_change_wallpaper () {
	if [ $(uname) = "Linux" ]
	then
		WINDOW_MANAGER=$(wmctrl -m | grep "Name: " | awk '{print $2}')
		if [ $WINDOW_MANAGER = $XFWM ]
		then
			change_wallpaper_Xfwm4
		fi
		if [ $WINDOW_MANAGER = $GNOME ]
		then
			change_wallpaper_GNOME
		fi
		if [ $WINDOW_MANAGER = $KDE ]
		then
			change_wallpaper_KDE
		else
			feh --bg-fill $FULL_PATH
		fi
	fi
	if [ $(uname) = $DARWIN ]
	then
		change_wallpaper_aqua
	fi
}

change_wallpaper () {
	WALLPATH=$(< /etc/bashwaller.conf)
	PAPE=$(ls $WALLPATH | shuf -n1)
	FULL_PATH="$WALLPATH/$PAPE"
	echo $FULL_PATH
	determine_wm_and_change_wallpaper
}

change_wallpaper
