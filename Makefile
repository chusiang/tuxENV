#TYPE=desktop
TYPE=server

# Init.

DIR_BAK=${HOME}/.tuxENV.bak.${TIMESTAMP}
TIMESTAMP=`date "+%Y-%m-%d-%H:%M:%S"`

DIR_BIN=${HOME}/bin
DIR_VCS=${HOME}/vcs

# - Bash
FILE_BASHRC=${HOME}/.bashrc
FILE_BASH_ALIASES=${HOME}/.bash_aliases
FILE_BASH_EXPORT=${HOME}/.bash_export
FILE_BASH_PROFILE=${HOME}/.bash_profile

# - Tools
FILE_SCREENRC=${HOME}/.screenrc
FILE_TMUXRC=${HOME}/.tmux.conf
FILE_EDIT_MODE=${HOME}/.inputrc
FILE_GITCONFIG=${HOME}/.gitconfig
FILE_MYCLIRC=${HOME}/.myclirc

# - Desktop
FILE_AWOKENRC=${HOME}/.AwOkenrc
FILE_EVILWMRC=${HOME}/.xinitrc
FILE_FONTSRC=${HOME}/.fonts.conf
FILE_MUTTATORRC=${HOME}/.muttatorrc
FILE_PENTADACTYLRC=${HOME}/.pentadactylrc

#  - URxvt
FILE_ICONS=${HOME}/.icons
FILE_URXVT=${HOME}/.urxvt
FILE_URXVTRC=${HOME}/.Xdefaults


.PHONY: backup install update 

all: backup install

backup:
	@echo '=> Backup start.'
	rm -rf ${HOME}/.tuxENV.bak/
	mkdir ${DIR_BAK}
	# Bash
	mv ${FILE_BASH_ALIASES} ${DIR_BAK}/
	mv ${FILE_BASH_EXPORT} ${DIR_BAK}/
	mv ${FILE_BASH_PROFILE} ${DIR_BAK}/
	mv ${FILE_BASHRC} ${DIR_BAK}/
	# Tools
	mv ${FILE_SCREENRC} ${DIR_BAK}/
	mv ${FILE_TMUXRC} ${DIR_BAK}/
	mv ${FILE_EDIT_MODE} ${DIR_BAK}/
	mv ${FILE_GITCONFIG} ${DIR_BAK}/
	mv ${FILE_MYCLIRC} ${DIR_BAK}/
ifeq ($(TYPE), desktop)
	mv ${FILE_AWOKENRC} ${DIR_BAK}/
	mv ${FILE_EVILWMRC} ${DIR_BAK}/
	mv ${FILE_FONTSRC} ${DIR_BAK}/
	mv ${FILE_MUTTATORRC} ${DIR_BAK}/
	mv ${FILE_PENTADACTYLRC} ${DIR_BAK}/
	mv ${FILE_URXVTRC} ${DIR_BAK}/
endif
	@echo '=> Done.'
	@echo ''

install:
	@echo '=> Install start.'
	cat home/_bash_aliases > ${FILE_BASH_ALIASES}
	cat home/_bash_export > ${FILE_BASH_EXPORT}
	cat home/_bash_profile > ${FILE_BASH_PROFILE}
	cat home/_bashrc > ${FILE_BASHRC}
	cat home/_screenrc > ${FILE_SCREENRC}
	cat home/_tmux.conf > ${FILE_TMUXRC}
	cat home/_inputrc > ${FILE_EDIT_MODE}
	cat home/_gitconfig > ${FILE_GITCONFIG}
	cat home/_myclirc > ${FILE_MYCLIRC}
	cp -a home/bin/ ${DIR_BIN} 
ifeq ($(TYPE), desktop)
	@echo '==> Install with desktop.'
	cat home/_fonts.conf > ${FILE_FONTSRC}
	cat home/_muttatorrc > ${FILE_MUTTATORRC}
	cat home/_pentadactylrc > ${FILE_PENTADACTYLRC}
	cat home/_xinitrc > ${FILE_EVILWMRC}
	cat home/_AwOkenrc > ${FILE_AWOKENRC}
	# URxvt
	cat home/_Xdefaults > ${FILE_URXVTRC}
	-rsync -aqz home/_urxvt/ ${FILE_URXVT}
	-rsync -aqz home/_icons/128x128terminal.png ${FILE_ICONS}/128x128terminal.png
endif
	@echo '=> Done.'
	@echo ''

update:
	@echo '=> Updating start.'
	# - Bash.
	rsync -aqz home/_bash_aliases ${FILE_BASH_ALIASES}
	rsync -aqz home/_bash_export ${FILE_BASH_EXPORT}
	rsync -aqz home/_bash_profile ${FILE_BASH_PROFILE}
	rsync -aqz home/_bashrc ${FILE_BASHRC}
	# - Tools.
	rsync -aqz home/_screenrc ${FILE_SCREENRC}
	rsync -aqz home/_tmux.conf ${FILE_TMUXRC}
	rsync -aqz home/_inputrc ${FILE_EDIT_MODE}
	rsync -aqz home/_gitconfig ${FILE_GITCONFIG}
	rsync -aqz home/_myclirc ${FILE_MYCLIRC}
	rsync -aqz home/bin/ ${DIR_BIN} 
ifeq ($(TYPE), desktop)
	@echo '==> Updating with desktop.'
	rsync -aqz home/_AwOkenrc ${FILE_AWOKENRC}
	rsync -aqz home/_fonts.conf ${FILE_FONTSRC}
	rsync -aqz home/_muttatorrc ${FILE_MUTTATORRC}
	rsync -aqz home/_pentadactylrc ${FILE_PENTADACTYLRC}
	rsync -aqz home/_xinitrc ${FILE_EVILWMRC}
	# URxvt
	rsync -aqz home/_Xdefaults ${FILE_URXVTRC}
	rsync -aqz home/_urxvt/ ${FILE_URXVT}
	rsync -aqz home/_icons/128x128terminal.png ${FILE_ICONS}/128x128terminal.png
endif
	@echo '=> Done.'
	@echo ''

