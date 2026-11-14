#!/usr/bin/env bash
# polybar-02: detecta rede/bateria/backlight e monta os modulos da direita
killall -q polybar; polybar-msg cmd quit >/dev/null 2>&1
export POLYBAR_PATH="$HOME/.config/polybar"
POLYBAR_IFACE=$(ip route 2>/dev/null | awk '/default/ {print $5; exit}')
export POLYBAR_IFACE=${POLYBAR_IFACE:-$(ls /sys/class/net | grep -v '^lo$' | head -1)}
mods="network date"
b=$(ls /sys/class/backlight 2>/dev/null | head -1)
[ -n "$b" ] && { export POLYBAR_BACKLIGHT=$b; mods="$mods backlight"; }
mods="$mods audio"
bat=$(ls /sys/class/power_supply 2>/dev/null | grep -E '^BAT' | head -1)
if [ -n "$bat" ]; then
  export POLYBAR_BAT=$bat POLYBAR_AC=$(ls /sys/class/power_supply | grep -E '^(AC|ADP)' | head -1)
  mods="$mods battery"
fi
export POLYBAR_MODS_RIGHT="$mods powermenu"
polybar -r main -c "$POLYBAR_PATH/config.ini" &
