#!/usr/bin/env bash
# rofi-layouts do dwm (Super+;) — específico do dwm. O dwm não tem IPC: aplica pelos atalhos Super+Ctrl+F1/F2/F3 (via xdotool).
opts=$'󰕰  tile (mestre à esquerda)|F1\n󰉈  flutuante|F2\n󰊓  monocle (uma janela por vez)|F3'
sel=$(printf '%s\n' "$opts" | cut -d'|' -f1 | rofi -dmenu -i -no-custom -p layout -mesg "layout da tag atual" -theme "$HOME/.config/rofi/rofi-top-01/menu.rasi") || exit 0
key=$(printf '%s\n' "$opts" | awk -F'|' -v s="$sel" '$1==s {print $2; exit}')
[ -n "$key" ] && sleep 0.15 && xdotool key --clearmodifiers "super+ctrl+$key"
