# waybar-min

Waybar **compacta (base Oak-conf/swaywm-rice)**, do rice ORCA do niri:

menu (rofi) + workspaces | relógio | rede, energia, volume — 520 px centralizada no topo

- Cores em `colors.css` (tema Base2Tone Space, Gogh): `@bg @bg2 @fg @accent @accent2 @urgent` + paleta.
- Workspaces pelo módulo `niri/workspaces` (sway: troque por `sway/workspaces`; Hyprland: `hyprland/workspaces`).

Preview: [../waybar-min.png](../waybar-min.png)

## Requisitos

waybar 0.10+, fonte Maple Mono NF (Nerd Font), niri (módulos niri/*), rofi, wlogout (botão de energia).

## Instalação

```sh
mkdir -p ~/.config/waybar && cp -r waybar-min/. ~/.config/waybar/
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```
