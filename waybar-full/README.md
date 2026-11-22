# waybar-full

Waybar **completa (base shadowofdominance/swaydots)**, do rice ORCA do niri:

workspaces + título da janela | relógio com calendário pt-BR de 3 meses | CPU, memória, rede, tray, volume, energia

- Cores em `colors.css` (tema Base2Tone Space, Gogh): `@bg @bg2 @fg @accent @accent2 @urgent` + paleta.
- Workspaces pelo módulo `niri/workspaces` (sway: troque por `sway/workspaces`; Hyprland: `hyprland/workspaces`).
- `scripts/relogio.py`: data/hora em pt-BR e calendário de 3 meses (anterior, atual, próximo) no tooltip, dia de hoje na cor de destaque.

Preview: [../waybar-full.png](../waybar-full.png)

## Requisitos

waybar 0.10+, fonte Maple Mono NF (Nerd Font), niri (módulos niri/*), wlogout (botão de energia), python3.

## Instalação

```sh
mkdir -p ~/.config/waybar && cp -r waybar-full/. ~/.config/waybar/
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```
