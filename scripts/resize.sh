#!/bin/sh

# This script is designed to resize a terminal running over a serial connection.
# After running an application like `vim`, the screen is resized so that it no longer fills the entire
# client terminal. This script will reset this configuration, fixing screen wrapping and other issues.

# Implementation taken from https://unix.stackexchange.com/questions/16578/resizable-serial-console-window

old=$(stty -g)
stty raw -echo min 0 time 5

printf '\0337\033[r\033[999;999H\033[6n\0338' > /dev/tty
IFS='[;R' read -r _ rows cols _ < /dev/tty

stty "$old"

# echo "cols:$cols"
# echo "rows:$rows"
stty cols "$cols" rows "$rows"
