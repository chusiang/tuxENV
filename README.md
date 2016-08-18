# My Linux Environment

- Author: [Chu-Siang Lai (凍仁翔)](http://note.drx.tw/)
- Build Date: 2013/02/07

If you like Vim, you can see my [vimrc](https://github.com/chusiang/vimrc).

## Setup

Clone tuxENV.
	
	$ git clone git@github.com:chusiang/tuxENV.git
	$ cd tuxENV/

Install

	$ make install
	
	# install tmux plugins.
	$ tmux
    → <Ctrl> + A + I
	

Update

	$ make update
	
Backup

	$ make backup

## Files List

bash:

```
_bash_aliases
_bash_export
_bash_profile
_bashrc
```

Vim like:

```
_bashrc         # Bash
_muttatorrc     # Thunderbird
_pentadactylrc  # Firefox
_screenrc       # Screen
_tmux.conf      # Tmux
```

rxvt-unicode:

```
_Xdefaults
_urxvt/ext/fullscreen
_icon/128x128terminal.png
```

xinput:

```
_xinput.d/
├── marble-scrolling.sh     # Scrolling for Marble Trackball.
├── trackpoint-scrolling.sh # Scrolling for Trackpoint.
└── wheel-scrolling.sh      # Scrolling for Wheel Trackball.
```

Other:

```
_AwOkenrc        # AwOken Icon theme.
_xinitrc.evilwm  # EvilWM
```

## Reference

* [Keyboard shortcuts | Firefox Help](https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly)
* [SammyLin/tmux-config | GitHub](https://github.com/SammyLin/tmux-config)

