#!/bin/bash
# Filename:	xdotool-fouce.sh
# Info:		launch and switch windows fouce, first you need to install the 'xdotool' package.
# Example:	$ ./xdotool-fouce.sh gvim

fouce () {
	WIDs=$( xdotool search "$1" 2> /dev/null )
	declare -i WIDn=$( echo "$WIDs" | wc -l )

	if [ "$WIDn" -gt 1 ]; then
		#echo "$1 found out - change fouce"
		WID=$( echo "$WIDs" | tail -n 1 )
		xdotool windowactivate --sync "$WID" &
	else
		#echo "lanuch ap $1"
		"$1" &
	fi
}

# = Main =
if [ $0 != $BASH_SOURCE ]; then
	return
fi
cmd=$1 ; shift

# - white list.
case $cmd in

	"gvim")
		fouce gvim
		;;

	"terminator")
		fouce terminator
		;;

	"nautilus")
		fouce nautilus
		;;

	"firefox")
		fouce firefox
		;;

	"chrome")
		fouce chrome
		;;

	"rxvt-unicode")
		fouce rxvt-unicode
		;;

	*)
		echo "not in the white list."
		;;

esac

# ------------------------------------
# Author : Chu-siang Lai
# E-mail : jonny (at) drx.tw
# Blog: http://note.drx.tw
# ------------------------------------

