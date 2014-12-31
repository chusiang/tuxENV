# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: netstat-wait.sh
#  Modified: 2014-12-31 21:22
#  Description: connection count.
#  Reference: Get this with locy [1].
#   1. locy - https://github.com/locy
# =========================================================== 

#!/bin/bash

netstat -n | awk '/^tcp/ {++state[$NF]} END {for(key in state) print key,"\t",state[key]}' | sort

