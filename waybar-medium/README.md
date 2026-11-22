# waybar-medium

Waybar **ilha (base diinki/diinki-retrofuture)**, do rice ORCA do niri:

menu (rofi) + workspaces | — | rede (banda), volume, tray, hora — cápsulas arredondadas

- Cores em `colors.css` (tema Base2Tone Space, Gogh): `@bg @bg2 @fg @accent @accent2 @urgent` + paleta.
- Workspaces pelo módulo `niri/workspaces` (sway: troque por `sway/workspaces`; Hyprland: `hyprland/workspaces`).

Preview: [../waybar-medium.png](../waybar-medium.png)

## Requisitos

waybar 0.10+, fonte Maple Mono NF (Nerd Font), niri (módulos niri/*), rofi.

## Instalação

```sh
mkdir -p ~/.config/waybar && cp -r waybar-medium/. ~/.config/waybar/
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```
