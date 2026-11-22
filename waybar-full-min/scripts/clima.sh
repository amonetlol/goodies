#!/bin/sh
# clima.sh — módulo custom da waybar: clima da cidade detectada pelo IP (wttr.in), em pt-BR. Saída JSON.
c="${XDG_CACHE_HOME:-$HOME/.cache}/waybar/clima.json"; mkdir -p "${c%/*}"
t=$(curl -fsS --max-time 15 'https://wttr.in/?format=%c%t&lang=pt-br' 2>/dev/null | tr -d '+')
d=$(curl -fsS --max-time 15 'https://wttr.in/?format=%l:+%C,+%t+(sensação+%f),+umidade+%h,+vento+%w&lang=pt-br' 2>/dev/null)
if [ -n "$t" ] && ! printf '%s' "$t" | grep -qi 'unknown\|error'; then
  python3 -c 'import json,sys;print(json.dumps({"text":sys.argv[1].strip(),"tooltip":sys.argv[2].strip()},ensure_ascii=False))' "$t" "$d" | tee "$c"
elif [ -s "$c" ]; then cat "$c"
else echo '{"text":"󰖐 --","tooltip":"clima indisponível"}'; fi
