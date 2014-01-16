#!/bin/bash

killall -9 $(ps aux | grep scim | awk '{print $2}')
