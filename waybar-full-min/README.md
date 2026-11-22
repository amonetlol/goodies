# waybar-full-min

Waybar **faixa (base atrskv/dotfiles)**, do rice ORCA do niri:

workspaces | clima (cidade pelo IP), memória, CPU | volume, data dom, 22/11, rede, energia

- Cores em `colors.css` (tema Base2Tone Space, Gogh): `@bg @bg2 @fg @accent @accent2 @urgent` + paleta.
- Workspaces pelo módulo `niri/workspaces` (sway: troque por `sway/workspaces`; Hyprland: `hyprland/workspaces`).
- `scripts/relogio.py`: data/hora em pt-BR e calendário de 3 meses (anterior, atual, próximo) no tooltip, dia de hoje na cor de destaque.
- `scripts/clima.sh`: clima da cidade detectada pelo IP (wttr.in, pt-BR), atualiza a cada 15 min, com cache.

Preview: [../waybar-full-min.png](../waybar-full-min.png)

## Requisitos

waybar 0.10+, fonte Maple Mono NF (Nerd Font), niri (módulos niri/*), wlogout (botão de energia), python3, curl.

## Instalação

```sh
mkdir -p ~/.config/waybar && cp -r waybar-full-min/. ~/.config/waybar/
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```
