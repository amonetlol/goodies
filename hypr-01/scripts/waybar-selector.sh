#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
# ──────────────────────────────────────────────
#   Waybar Style Selector
# ──────────────────────────────────────────────

SCRIPT_DIR="$SCRIPTS_DIR"
WAYBAR_THEMES_DIR="$WAYBAR_DIR/themes"
ACTIVE_THEME_FILE="$THEME_DIR/.active-theme"

"$SCRIPT_DIR/ensure-rofi-links.sh"

CHOICE=$(ls "$WAYBAR_THEMES_DIR" | sort | rofi -no-config -dmenu -no-custom -i -p "  Waybar Style" -theme "$ROFI_DIR/selectors.rasi")

[ -z "$CHOICE" ] && exit 0
[[ "$CHOICE" != */* && -f "$WAYBAR_THEMES_DIR/$CHOICE/config.jsonc" && -f "$WAYBAR_THEMES_DIR/$CHOICE/style.css" ]] || exit 1

ln -sfn "themes/$CHOICE/config.jsonc" "$WAYBAR_DIR/config.jsonc"
ln -sfn "themes/$CHOICE/style.css" "$WAYBAR_DIR/style.css"

killall waybar 2>/dev/null
sleep 0.3
"$SCRIPTS_DIR/start-waybar.sh" & disown

notify-send "  Waybar Updated" "Style: $CHOICE applied" -i preferences-desktop-theme
