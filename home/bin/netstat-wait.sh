#!/bin/bash
# Filename: netstat-wait.sh
# Info:		connection count.

netstat -n | awk '/^tcp/ {++state[$NF]} END {for(key in state) print key,"\t",state[key]}' | sort

