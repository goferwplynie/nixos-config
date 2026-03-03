#!/usr/bin/env bash
if [ -z "$1" ]; then
    exit 1
fi

WALLPAPER="$1"
wallust run "$WALLPAPER"

swww-daemon > /dev/null 2>&1 &
swww img "$WALLPAPER" --transition-fps 60 --transition-type wipe --transition-duration 2


pkill waybar
waybar > /dev/null 2>&1 &


