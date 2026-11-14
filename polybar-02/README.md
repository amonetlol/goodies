# polybar-02

Barra baseada em [mino29/arch-i3](https://github.com/mino29/arch-i3/tree/master/.config/polybar) (tema tokyo-night), adaptada para **qtile / qualquer WM com EWMH**.

Mudancas em relacao ao original:
- `internal/i3` -> `internal/xworkspaces`; removido `wm-restack = i3`.
- Icones trocados por Nerd Font v3 (os do original sao da v2 e nao existem na v3).
- Modulos da direita (rede, backlight, bateria) detectados pelo `launch.sh`; interface de rede automatica.
- Spotify/zscroll/syncthing/updates (scripts externos) removidos; prev/play/next via `playerctl` (qualquer player).
- Powermenu via rofi (`scripts/powermenu.sh`); logout pelo qtile.

Uso: copiar para `~/.config/polybar` e rodar `launch.sh` (autostart do qtile). Requer `polybar`, `ttf-hack-nerd`, `playerctl`, `rofi`.

Preview: `polybar-02.png`
