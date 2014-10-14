#!/usr/bin/python
# -*- coding: utf8 -*-
# Copyleft (C) 2014 chusiang (凍仁翔) <chusiang.lai -AT- gmail.com>
# Last Modified: 4 Oct 2014
# Released under GNU General Public License 3.0

"""
  The script will switch the fouce to the 'process' if it has exist, else the script will execute a new 'process'. And it`s need the xdotool 3.2+, please install it, first.

    # under the Debian/Ubuntu. 
    $ sudo apt-get install xdotool

  We can quick switch fouce like under command, now.

    $ python fouce.py firefox
    $ python fouce.py gvim
    $ python fouce.py rxvt

  Finally, we can integration the keyboard shortcuts with compiz or xbindkey, like this:

    <Super>1 gvim
    <Super>2 rxvt
    <Super>3 caja  # File Manager for MATE Desktop Environment.
    <Super>4 iceweasel
    <Super>5 chromium
    <Super>6 chrome
"""

import sys
import os
import commands

# Get the argument of '$1'.
process_name = sys.argv[1]

try:
    # get process list.
    process_output = commands.getoutput('ps -A')
    if process_name in process_output:
        # The Caja is different of other process. It usually bas ran at background.
        if process_name == 'caja':
            caja_count = commands.getoutput('xdotool search --onlyvisible ' + process_name + ' | wc -l 2> /dev/null')
            if caja_count > 1:
                # switch window.
                os.system("xdotool windowactivate --sync $(xdotool search --onlyvisible " + process_name + " | tail -1) 2> /dev/null")
        else:
            # switch window.
            os.system("xdotool windowactivate --sync $(xdotool search --onlyvisible " + process_name + ") 2> /dev/null")
    else:
        # execute application.
        os.system(process_name)
except:
    print "Something wrong, It`s has not run anything."
