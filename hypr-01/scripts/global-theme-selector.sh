#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
# ──────────────────────────────────────────────
#   Enhanced Theme & Style Selector
# ──────────────────────────────────────────────

SCRIPT_DIR="$SCRIPTS_DIR"

WALL_DIR="${WALLPAPER_DIR:-$HOME/Imagens/wallpapers}"
SWWW_SCRIPT="$SCRIPTS_DIR/swww-all.sh"
ACTIVE_THEME_FILE="$THEME_DIR/.active-theme"
CURRENT=$(cat "$ACTIVE_THEME_FILE" 2>/dev/null || echo "unknown")

"$SCRIPTS_DIR/ensure-rofi-links.sh"

MENU="󰏘  Material\n󰉺  Retro\n󰔉  Modern\n󰂫  Glass\n󰘵  Noro\n────────────────────\n󰃟  Change Wallpaper\n󰕮  Change Waybar Style"

CHOICE=$(echo -e "$MENU" | rofi -no-config -dmenu -i -p "  Theme [$CURRENT]" -theme "$ROFI_DIR/selectors.rasi")

[ -z "$CHOICE" ] || [[ "$CHOICE" == "───"* ]] && exit 0

case "$CHOICE" in
    *"Change Wallpaper"*)
        "$SCRIPTS_DIR/wall-selector.sh"
        exit 0 ;;
    *"Change Waybar Style"*)
        "$SCRIPTS_DIR/waybar-selector.sh"
        exit 0 ;;
    *"Material"*) THEME="Material"; HYPR="material"; WAYBAR="floating-bar"; WALL="material" ;;
    *"Retro"*)    THEME="Retro";    HYPR="retro";    WAYBAR="retro";   WALL="retro" ;;
    *"Modern"*)   THEME="Modern";   HYPR="modern";   WAYBAR="dock";  WALL="modern" ;;
    *"Glass"*)    THEME="Glass";    HYPR="glass";    WAYBAR="glass";  WALL="glass" ;;
    *"Noro"*)     THEME="Noro";     HYPR="noro";     WAYBAR="noro";         WALL="noro" ;;
    *) exit 0 ;;
esac

ln -sfn "themes/$HYPR/theme.conf" "$THEME_DIR/theme.conf"
if [ -f "$HYPR_THEMES_DIR/$HYPR/theme.lua" ]; then
    ln -sfn "themes/$HYPR/theme.lua" "$THEME_DIR/theme.lua"
fi
ln -sfn "themes/$WAYBAR/config.jsonc" "$WAYBAR_DIR/config.jsonc"
ln -sfn "themes/$WAYBAR/style.css" "$WAYBAR_DIR/style.css"
ln -sfn "themes/$HYPR/launcher.rasi" "$ROFI_DIR/active-launcher.rasi"
ln -sfn "themes/$HYPR/scripts.rasi" "$ROFI_DIR/active-scripts.rasi"


echo "$THEME" > "$ACTIVE_THEME_FILE"

WALL_SEARCH="$WALL_DIR/$WALL"
[ ! -d "$WALL_SEARCH" ] && WALL_SEARCH="$WALL_DIR"
SELECTED_WALL=$(find "$WALL_SEARCH" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) 2>/dev/null | shuf -n 1)
[ -n "$SELECTED_WALL" ] && "$SWWW_SCRIPT" "$SELECTED_WALL"

hyprctl reload
killall waybar 2>/dev/null
"$SCRIPTS_DIR/start-waybar.sh" & disown

notify-send "  Theme: $THEME" "Full system aesthetic updated" -i preferences-desktop-theme
