#!/usr/bin/env bash

install() {
	echo "=== INSTALLING BASHWALLER.SH ==="
	echo "Enter (absolute) path to wallpaper directory: "
	read $WALLPATH
	cat $WALLPATH > config
	echo "=== COPYING SCRIPT TO /usr/bin ==="
	sudo cp bashwaller.sh /usr/bin
	echo "=== COPYING CONFIG TO /etc/bashwaller.conf ==="
	sudo cp config
}

install
