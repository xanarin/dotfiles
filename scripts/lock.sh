export LC_ALL=en_US.UTF-8
param=("--textcolor=00000000" "--insidecolor=0000001c" "--ringcolor=0000003e" \
        "--linecolor=00000000" "--keyhlcolor=ffffff80" "--ringvercolor=ffffff00" \
        "--separatorcolor=22222260" "--insidevercolor=ffffff1c" \
        "--ringwrongcolor=ffffff55" "--insidewrongcolor=ffffff1c")
mpc pause
i3lock -i $HOME/.scripts/current_wallpaper "${param[@]}"
