#!/usr/bin/env bash
CITY="${WAYBAR_WEATHER_CITY:-}"   # vazio = wttr.in detecta pela rede; ex.: export WAYBAR_WEATHER_CITY=Sao+Paulo
out=$(curl -fsS -m 8 --get "https://wttr.in/${CITY}" \
  --data-urlencode "lang=pt" \
  --data-urlencode "format=%c %t" 2>/dev/null | tr -s ' ' | sed 's/^ *//;s/ *$//')
if [[ -z $out ]]; then
  echo '{"text":"󰖐 —","tooltip":"Clima indisponível"}'
  exit 0
fi
tooltip=$(curl -fsS -m 8 --get "https://wttr.in/${CITY}" \
  --data-urlencode "lang=pt" \
  --data-urlencode "format=%l: %c %t / sensação %f\nUmidade: %h  Vento: %w" 2>/dev/null | tr -s ' ' || echo "Clima")
python3 - "$out" "$tooltip" <<'PY'
import json,sys
print(json.dumps({"text": sys.argv[1], "tooltip": sys.argv[2]}, ensure_ascii=False))
PY
