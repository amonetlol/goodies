#!/usr/bin/env bash
set -euo pipefail
HOME_DIR="${HOME}"
WALL="$HOME_DIR/.config/hypr3/wallpapers/02.jpg"
if command -v awww-daemon >/dev/null 2>&1; then
  pgrep -x awww-daemon >/dev/null || awww-daemon &
  sleep 0.3
  [ -f "$WALL" ] && awww img "$WALL" || awww img "$HOME_DIR/.config/hypr3/wallpapers/02.jpg" 2>/dev/null || true
fi
