#!/usr/bin/env bash
set -euo pipefail
wall="${1:-$HOME/.config/hypr/wallpapers/wallpaper.jpg}"
[[ -r "$wall" ]] || { echo "Wallpaper nao encontrado: $wall" >&2; exit 1; }
command -v swaybg >/dev/null || { echo "swaybg nao encontrado" >&2; exit 1; }
pkill -u "$(id -u)" -x swaybg 2>/dev/null || true
swaybg -i "$wall" -m fill >/tmp/hypr-swaybg.log 2>&1 &
