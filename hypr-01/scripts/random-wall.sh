#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1

# ──────────────────────────────────────────────
#   Random Theme Switcher
# ──────────────────────────────────────────────

SCRIPT_DIR="$SCRIPTS_DIR"

WALL_DIR="${WALLPAPER_DIR:-$HOME/Imagens/wallpapers}"
SCRIPT="$SCRIPT_DIR/swww-all.sh"

SELECTED_WALL=$(find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)

if [ -n "$SELECTED_WALL" ]; then
    "$SCRIPT" "$SELECTED_WALL"
else
    notify-send "Wallpaper Error" "No images found in $WALL_DIR" -u critical
fi
