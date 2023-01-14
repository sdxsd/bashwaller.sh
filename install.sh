#!/usr/bin/env bash

install() {
	WALLPATH=""
	echo "=== INSTALLING BASHWALLER.SH ==="
	echo "Enter (absolute) path to wallpaper directory: "
	read WALLPATH
	echo $WALLPATH > bashwaller.conf
	echo "=== COPYING SCRIPT TO /usr/bin ==="
	sudo cp bashwaller.sh /usr/bin/
	echo "=== COPYING CONFIG TO /etc/bashwaller.conf ==="
	sudo cp bashwaller.conf /etc/bashwaller.conf
}

install
