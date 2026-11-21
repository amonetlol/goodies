#!/usr/bin/env bash
# menu de energia (Super+X) — OutTheme/Traffic. Sair: ajuste LOGOUT_CMD para o seu WM (padrão: encerra o dwm)
up="$(uptime -p | sed -e 's/up //; s/weeks\?/semana(s)/; s/days\?/dia(s)/; s/hours\?/hora(s)/; s/minutes\?/minuto(s)/')"
suspend='󰤄  Suspender'; logout='󰍃  Sair do dwm'; reboot='󰜉  Reiniciar'; shutdown='󰐥  Desligar'
opts="$suspend"$'\n'"$logout"$'\n'"$reboot"$'\n'"$shutdown"
chosen=$(printf '%s\n' "$opts" | rofi -dmenu -i -no-custom -p energia -mesg "󰔟  ligado há $up" -theme "$HOME/.config/rofi/rofi-top-01/menu.rasi") || exit 0
case "$chosen" in
  "$shutdown") systemctl poweroff ;;
  "$reboot")   systemctl reboot ;;
  "$suspend")  systemctl suspend ;;
  "$logout")   ${LOGOUT_CMD:-pkill -x dwm} ;;
esac
