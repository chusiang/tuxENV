#!/usr/bin/python
# -*- coding: utf8 -*-

import sys
import os
import commands

# Get the argument of '$1'.
process_name = sys.argv[1]

try:
    # get process list.
    process_output = commands.getoutput('ps -A')

    """
    The script will switch the fouce to the 'process' if it has exist,
    else the script will execute a new 'process'.
    """
    if process_name in process_output:
        # The Caja is different of other process. It usually bas ran at background.
        if process_name == 'caja':
            caja_count = commands.getoutput('xdotool search --onlyvisible caja | wc -l')
            if caja_count > 1:
                # switch window.
                os.system("xdotool windowactivate --sync $(xdotool search --onlyvisible " + process_name + " | tail -1) 2> /dev/null")
            else:
                # execute application.
                os.system(process_name)
        else:
            # switch window.
            os.system("xdotool windowactivate --sync $(xdotool search --onlyvisible " + process_name + ") 2> /dev/null")
    else:
        # execute application.
        os.system(process_name)
except:
    print "Something wrong, It`s has not run anything."
