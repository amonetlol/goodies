#!/usr/bin/env bash
set -euo pipefail
source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
WALLPAPER="${1:-}"
[[ -r "$WALLPAPER" ]] || { echo "Usage: $0 /path/to/wallpaper" >&2; exit 1; }
"$SCRIPTS_DIR/WallpaperDaemon.sh" "$WALLPAPER"
if command -v matugen >/dev/null 2>&1 && [[ -r "$MATUGEN_CONFIG" ]]; then
  matugen image "$WALLPAPER" -c "$MATUGEN_CONFIG" --source-color-index 0
fi
killall -SIGUSR2 waybar 2>/dev/null || true
hyprctl reload 2>/dev/null || true
killall -SIGUSR1 nvim 2>/dev/null || true
pywalfox update 2>/dev/null || true
notify-send "Theme Updated" "Colors extracted from $(basename "$WALLPAPER")" -i "$WALLPAPER" 2>/dev/null || true
