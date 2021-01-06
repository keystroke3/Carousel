#!/bin/sh
ping -c 1 -w 1 google.com &>/dev/null && echo "" || ip a | grep 'BROADCAST,MULTICAST,UP,LOWER_UP'>/dev/null &&  echo "!" || echo ""
