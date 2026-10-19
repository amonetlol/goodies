#!/usr/bin/env bash
CFG="$HOME/.config/hypr3/waybar/config.jsonc"
CSS="$HOME/.config/hypr3/waybar/style.css"
pkill -x waybar 2>/dev/null || true
sleep 0.15
waybar -c "$CFG" -s "$CSS" >/dev/null 2>&1 &
