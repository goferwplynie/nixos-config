#!/usr/bin/env bash

WALL_DIR="$HOME/.config/.wallpapers"

# check if directory exists
if [ ! -d "$WALL_DIR" ]; then
    exit 1
fi

# find only .jpg or .png files 
CHOICE=$(find -L "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | while read -r file; do
# show images (some rofi feature ~w~)
    echo -en "$(basename "$file")\x00icon\x1f$file\n"
done | rofi -dmenu -i -show-icons -p "Pick wallpaper :3" -theme-str 'window { width: 50%; } listview { columns: 3; lines: 4; }')

if [ -n "$CHOICE" ]; then
    wall-set.sh "$WALL_DIR/$CHOICE"
fi
