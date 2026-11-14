#!/usr/bin/env bash
# menu de energia (rofi). Logout pelo qtile; se nao houver, encerra a sessao do usuario.
o=$(printf '%s\n' "Bloquear" "Sair" "Reiniciar" "Desligar" | rofi -dmenu -i -p "Power")
case $o in
  Bloquear)  loginctl lock-session;;
  Sair)      qtile cmd-obj -o cmd -f shutdown 2>/dev/null || pkill -KILL -u "$USER";;
  Reiniciar) systemctl reboot;;
  Desligar)  systemctl poweroff;;
esac
