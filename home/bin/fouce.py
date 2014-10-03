#!/usr/bin/python
# -*- coding: utf8 -*-

import sys
import os
import commands

# 宣告 $1 為 process_name。
process_name = sys.argv[1]

try:
    print "Switching to the " + process_name + "."
    process_output = commands.getoutput('ps -A')

    if process_name in process_output:
        print process_name + " exist."

        if process_name == 'caja':
            caja_count = commands.getoutput('xdotool search --onlyvisible caja | wc -l')
            if caja_count > 1:
                os.system("xdotool windowactivate --sync $(xdotool search --onlyvisible " + process_name + " | tail -1) 2> /dev/null")
            else:
                os.system(process_name)

        else:
            os.system("xdotool windowactivate --sync $(xdotool search --onlyvisible " + process_name + ") 2> /dev/null")
    else:
        print process_name + " not exist."
        os.system(process_name)

except:
    print "Not running."
