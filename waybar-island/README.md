# waybar-island

Waybar **3 ilhas (full-min em cápsulas)**, do rice ORCA do niri:

igual à full-min, com esquerda, centro e direita em cápsulas separadas sobre fundo transparente

- Cores em `colors.css` (tema Base2Tone Space, Gogh): `@bg @bg2 @fg @accent @accent2 @urgent` + paleta.
- Workspaces pelo módulo `niri/workspaces` (sway: troque por `sway/workspaces`; Hyprland: `hyprland/workspaces`).
- `scripts/relogio.py`: data/hora em pt-BR e calendário de 3 meses (anterior, atual, próximo) no tooltip, dia de hoje na cor de destaque.
- `scripts/clima.sh`: clima da cidade detectada pelo IP (wttr.in, pt-BR), atualiza a cada 15 min, com cache.

Preview: [../waybar-island.png](../waybar-island.png)

## Requisitos

waybar 0.10+, fonte Maple Mono NF (Nerd Font), niri (módulos niri/*), wlogout (botão de energia), python3, curl.

## Instalação

```sh
mkdir -p ~/.config/waybar && cp -r waybar-island/. ~/.config/waybar/
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```
