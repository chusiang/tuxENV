#!/bin/bash
# Filename:	xdotool-fouce.sh
# Info:		launch and switch windows fouce, first you need to install the 'xdotool' package.
# Example:	$ ./xdotool-fouce.sh gvim

# - Global
fouce () {
	WIDs=$( xdotool search "$1" 2> /dev/null )
	declare -i WIDn=$( echo "$WIDs" | wc -l )

	if [ "$WIDn" -gt 1 ]; then
		#echo "$1 found out - change fouce"
		WID=$( echo "$WIDs" | head -n 1 )
		xdotool windowactivate --sync "$WID" &
	else
		#echo "lanuch ap $1"
		"$1" &
	fi
}

# - only for nautilus on Ubuntu 10.04
fouce-nautilus () {
	WIDs=$( xdotool search "$1" 2> /dev/null )
	declare -i WIDn=$( echo "$WIDs" | wc -l )

	if [ "$WIDn" -gt 6 ]; then
		#echo "$1 found out - change fouce"
		WID=$( echo "$WIDs" | sed -n '5p' )
		xdotool windowactivate --sync "$WID" 2> /dev/null &
	else
		#echo "lanuch ap $1"
		"$1" &
	fi
}

# - only for rxvt-unicode on Debian 7.0
fouce-urxvt () {
	WIDs=$( xdotool search "$1" 2> /dev/null )
	URXVT_COUNT=$(ps aux | grep rxvt-unicode | wc -l)

	if [ "$URXVT_COUNT" -gt 1 ]; then
		#echo "$1 found out - change fouce"
		WID=$( echo "$WIDs" | head -n 1 )
		xdotool windowactivate --sync "$WID" 2> /dev/null &
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
		fouce-nautilus nautilus
		;;

	"iceweasel")
		fouce iceweasel
		;;

	"chromium")
		# only google-chrome, not chrome on lucid, so link it by myself.
		# $ ln -s /usr/bin/google-chrome ~/bin/chrome
		fouce chromium
		;;

	"google-chrome")
		# only google-chrome, not chrome on lucid, so link it by myself.
		# $ ln -s /usr/bin/google-chrome ~/bin/chrome
		fouce google-chrome
		;;

	"lxterminal")
		fouce lxterminal
		;;

	"rxvt-unicode")
		fouce-urxvt rxvt-unicode
		;;

	*)
		echo "not in the white list."
		;;

esac

# ------------------------------------
# Author : Chu-Siang Lai
# E-mail : jonny (at) drx.tw
# Blog: http://note.drx.tw
# ------------------------------------

