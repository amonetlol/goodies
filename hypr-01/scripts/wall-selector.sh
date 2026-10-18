#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1

SCRIPT_DIR="$SCRIPTS_DIR"

"$SCRIPT_DIR/ensure-rofi-links.sh"

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Imagens/wallpapers}"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory not found"
    exit 1
fi

SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) -exec basename {} \; | rofi -no-config -dmenu -i -p "Select Wallpaper" -theme "$ROFI_DIR/selectors.rasi")

if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALLPAPER_DIR/$SELECTED"
    "$SCRIPT_DIR/swww-all.sh" "$FULL_PATH"
fi
