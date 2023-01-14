#!/usr/bin/env bash

XFWM="Xfwm4"
GNOME="GNOME"
DARWIN="Darwin"
FULL_PATH=""

change_wallpaper_aqua () {
	CMD="'tell application \"Finder\" to set desktop picture to POSIX file \"$FULL_PATH\"'"
	zsh -c "osascript -e $CMD"
}

change_wallpaper_xfce4 () {
	LIST=($(xfconf-query -c xfce4-desktop -l | \
		grep "monitor" | grep "last-image"))
	for MONITOR in "${LIST[@]}"
	do
		xfconf-query -c xfce4-desktop -p $MONITOR -s $FULL_PATH
	done
}

determine_wm () {
	if [ $(uname) = "Linux" ]
	then
		WINDOW_MANAGER=$(wmctrl -m | grep "Name: " | awk '{print $2}')
		if [ $WINDOW_MANAGER = $XFWM ]
		then
			change_wallpaper_xfce4
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
	determine_wm
}

change_wallpaper
