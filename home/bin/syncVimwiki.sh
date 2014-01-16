#!/bin/bash

# = Vimwiki path =
strLinux="/media/data_ext3/home.d/vim/vimwiki"
strWindows="/media/Windows7/Users/jonny/vimwiki"

# = function =
fnPutToWindows () {
	local blnPut
	read -p "Do you want to sync ? [y]es / [n]o ? " blnPut

	if [ "$blnPut" = "Y" ] || [ "$blnPut" = "y" ]; then 
		rsync -vzrtopg --progress --delete $strLinux/ $strWindows
		echo
		echo "--------------------------------------------------------"
		echo "Put to Windows 7 (sda2)."
		echo
	else
		echo "It\`s be cancel."
		echo
	fi
}

fnGetFromWindows () {
	local blnGet
	read -p "Do you want to sync ? [y]es / [n]o ? " blnGet

	if [ "$blnGet" == "Y" ] || [ "$blnGet" == "y" ]; then 
		rsync -vzrtopg --progress --delete $strWindows/ $strLinux
		echo
		echo "--------------------------------------------------------"
		echo "Get from Windows 7 (sda2)."
		echo
	else
		echo "It\`s be cancel."
		echo
	fi
}

# = Main =
echo "--------------------------------------------------------"
echo "Welcome to Chusiang\`s Vimwiki sync to ThinkPad scripts."
echo -en "Which one do you need? [p]ut / [g]et ? \t"
read strChoose
echo "--------------------------------------------------------"

case $strChoose in

	# Put Vimwiki to Windows 7.
	"p" )	
		if [ -d /media/Windows7/Users/jonny/vimwiki ]; then 
			echo
			rsync -vzrtopgn --progress --delete $strLinux/ $strWindows
			echo
			echo "--------------------------------------------------------"
			fnPutToWindows
		else
			echo "--------------------------------------------------------"
			echo "Not found directory of Vimwiki on sda2."
			echo "--------------------------------------------------------"
		fi ;;

	# Get Vimwiki from Windows 7.
	"g" )	
		if [ -d /media/data_ext3/home.d/vim/vimwiki ]; then 
			echo
			rsync -vzrtopgn --progress --delete $strWindows/ $strLinux
			echo
			echo "--------------------------------------------------------"
			fnGetFromWindows
		else
			echo "--------------------------------------------------------"
			echo "Not found directory of Vimwiki on sdb2."
			echo "--------------------------------------------------------"
		fi ;;
	
	# Other.
	* )
		echo "bye." ;;

esac
