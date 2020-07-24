#!/bin/sh

if [ -z "$1" ] ; then
	echo "must provide volume"
	exit 1
fi

amixer sset Master $1

notify-send -h STRING:synchronous:volume "Volume $(amixer sget Master | egrep -o '[0-9]+%' | head -n 1)"
