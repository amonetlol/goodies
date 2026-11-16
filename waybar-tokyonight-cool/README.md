# waybar-tokyonight-cool

Waybar em pilhas arredondadas (tema `tokyo-2` do arch-mango), para **MangoWM** (Wayland). Paleta azul (Catppuccin Frappe/Tokyo Night) sobre fundo escuro translucido.

![bar](preview/bar.png)

Esquerda: logo, workspaces (tag ativa larga + bolinhas nas ocupadas), musica e **indicador de layout** do mango.
Centro: relogio. Direita: grupos **CPU/memoria** e **configuracoes** (iniciam expandidos; clique abre/fecha), bandeja, notificacoes (swaync) e **botao de energia** (ultimo modulo).

## Requisitos
- **waybar >= 0.16** (`start-expanded` do drawer nao existe na 0.15; no Gentoo: `gui-apps/waybar-9999`, com USE `tray mpris network backlight wifi`).
- mango (modulo `ext/workspaces` e `mmsg`), `swaync`, `rofi`, `jq`, `wlr-randr`, Nerd Font (Maple Mono NF CN / JetBrainsMono NF), `nm-applet`, `pwvucontrol`/pipewire.

## Estrutura
- `waybar/` — `config`, `style.css` e `module/` (workspace, notificacao, musica, monitor).
- `scripts/` — `waybar-layout` (layout do mango via `mmsg watch monitor`, emite JSON), `waybar-loop` (reinicia a waybar se cair), `power-menu.sh` (rofi) e `mango-layout-menu.sh` (clique no indicador).
- `state/` — `colors.css`, `fonts.css` e `opaque/waybar.css` importados pelo `style.css`.

## Instalar
```bash
mkdir -p ~/.config/waybar ~/.local/state/hakuspace/theme ~/.local/bin
cp -r waybar/* ~/.config/waybar/
cp state/colors.css state/fonts.css ~/.local/state/hakuspace/theme/
mkdir -p ~/.local/state/hakuspace/theme/opaque && cp state/opaque/waybar.css ~/.local/state/hakuspace/theme/opaque/
install -m755 scripts/* ~/.local/bin/
sudo install -m755 scripts/waybar-loop /usr/local/bin/waybar-loop   # e no autostart do mango: exec_once=waybar-loop
```
Recarregar sem reiniciar: `pkill -SIGUSR2 waybar` (no mango: bind `SUPER,F12`).

## Notas
- O `config` usa caminhos `$HOME/.config/waybar/module/...` e `$HOME/.local/bin/...`.
- Layout do mango: `S` scroller, `T` tile, `G` grid, `M` monocle (abas), `K` deck (empilhado) etc.; rolar o mouse sobre o indicador alterna, clicar abre o menu.
- Se a waybar cair no login (portal D-Bus lento), use o `waybar-loop`.
