#!/bin/sh
# launcher (Super+D): launcher.sh [drun|run|window] — drun no OutTheme com ícones; run/window no menu.rasi
m=${1:-drun}; t="$HOME/.config/rofi/rofi-top-01/outtheme.rasi"
[ "$m" = drun ] || t="$HOME/.config/rofi/rofi-top-01/menu.rasi"
exec rofi -show "$m" -terminal "${TERMINAL:-kitty}" -theme "$t"
