# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: xdotool-fouce-precise.sh
#  Modified: 2014-12-31 21:46
#  Description: launch and switch windows fouce, first you need to install the 'xdotool' package for Ubuntu 12.04.
#    Ex: $ ./xdotool-fouce.sh firefox
#  Reference: 
# =========================================================== 

#!/bin/bash

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

# Main
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
