# archcraft-sway — rofi

Rofis do Archcraft (sway), copiados da VM ONE-ARCH (`~/.config/sway/rofi`, `~/.config/rofi/config.rasi` e scripts `rofi_*`).

- `rofi/` — temas `.rasi` (launcher, runner, powermenu, screenshot, asroot, music, bluetooth, networkmenu, confirm, askpass), `shared/colors.rasi`, `shared/fonts.rasi`, `config-global.rasi` (era `~/.config/rofi/config.rasi`).
- `scripts/` — `rofi_*` que chamam os temas (esperam `~/.config/sway/rofi` e `~/.config/sway/scripts`).
- `previews/` — captura de tela de cada rofi no sway real (grim, 1704x920): launcher, runner, powermenu, screenshot, asroot, mpd, bluetooth, network, askpass, confirm. `_montage-8.png` mostra 8 deles juntos.

Nota: bluetooth e confirm foram capturados com entradas de exemplo (a VM não tem bluetooth); os demais, com os scripts reais. O preview do mpd mostra "Offline"/estado do mpc da VM.
