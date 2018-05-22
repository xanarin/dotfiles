#!/bin/bash
if [ "$5" == "LOW" ]; then
    exit 0;
fi

if [ "$1" == "Electron" ]; then
    # Make different noise for Mattermost and Matrix
    /usr/bin/mpv --really-quiet --volume 100 /home/will/.scripts/confident.ogg &
else
    /usr/bin/mpv --really-quiet --volume 100 /home/will/.scripts/facebook.ogg &
fi


