# Waybar — Omunchy

Barra flat do Omunchy (mango + noctalia), estilo Omarchy quattro.

## Layout

- **Esquerda:** menu · workspaces (dots)
- **Centro:** clima (wttr.in) · data pt-BR · hora · updates
- **Direita:** tray · mem · cpu · bluetooth · rede · áudio · brilho · bateria · power profile · mpris · power

## Dependências

Waybar, curl, jq/python3 (scripts), JetBrains Mono (ou Nerd Font), locale opcional. Integração com `noctalia msg` nos cliques.

## Uso

```bash
cp -r waybar-omunchy/v1/* ~/.config/waybar/
# ajuste a cidade em scripts/weather.sh se quiser
pkill -x waybar; waybar &
```

Preview: `preview.png` (v1: menu com ícone 󰍜)

- Clima (`scripts/weather.sh`): sem configuração o wttr.in detecta a cidade pela rede; para fixar, `export WAYBAR_WEATHER_CITY=Sao+Paulo` (no ambiente da sessão).
