#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
# ──────────────────────────────────────────────
#   Theme-Aware Wallpaper Selector
# ──────────────────────────────────────────────

SCRIPT_DIR="$SCRIPTS_DIR"

"$SCRIPT_DIR/ensure-rofi-links.sh"

WALL_DIR="${WALLPAPER_DIR:-$HOME/Imagens/wallpapers}"
ACTIVE_THEME_FILE="$THEME_DIR/.active-theme"
SWWW_SCRIPT="$SCRIPT_DIR/swww-all.sh"

THEME=$(cat "$ACTIVE_THEME_FILE" 2>/dev/null || echo "material")
THEME_DIR_NAME=$(echo "$THEME" | tr '[:upper:]' '[:lower:]')

[ ! -d "$WALL_DIR/$THEME_DIR_NAME" ] && THEME_DIR_NAME="."

CHOICE=$(find "$WALL_DIR/$THEME_DIR_NAME" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) -printf "%f\n" | sort | rofi -dmenu -i -p "  Wallpaper [$THEME]" -theme "$ROFI_DIR/selectors.rasi")

[ -z "$CHOICE" ] && exit 0

"$SWWW_SCRIPT" "$WALL_DIR/$THEME_DIR_NAME/$CHOICE"
