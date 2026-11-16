# waybar-tokyonight-cool

Waybar em pilhas arredondadas (tema `tokyo-2` do arch-mango) para **MangoWM** (Wayland), em duas variantes:

| `dark/` (azul Frappe / Tokyo Night, fundo escuro) | `light/` (azul Latte, pilulas claras) |
|---|---|
| ![dark](dark/preview/bar.png) | ![light](light/preview/bar.png) |

Esquerda: logo, workspaces (tag ativa larga + bolinhas nas ocupadas), musica e **indicador de layout** do mango.
Centro: relogio. Direita: grupos **CPU/memoria** e **configuracoes** (iniciam expandidos; clique abre/fecha), bandeja, notificacoes (swaync) e **botao de energia** (ultimo modulo).

## Requisitos
- **waybar >= 0.16** (`start-expanded` do drawer nao existe na 0.15; no Gentoo: `gui-apps/waybar-9999`, com USE `tray mpris network backlight wifi`).
- mango (modulo `ext/workspaces` e `mmsg`), `swaync`, `rofi`, `jq`, `wlr-randr`, Nerd Font (Maple Mono NF CN / JetBrainsMono NF), `nm-applet`, `pwvucontrol`/pipewire.

## Estrutura (igual em `dark/` e `light/`)
- `waybar/` — `config`, `style.css` e `module/` (workspace, notificacao, musica, monitor).
- `scripts/` — `waybar-layout` (layout do mango via `mmsg watch monitor`, emite JSON), `waybar-loop` (reinicia a waybar se cair), `power-menu.sh` (rofi) e `mango-layout-menu.sh` (clique no indicador).
- `state/` — `colors.css` (paleta), `fonts.css` e `opaque/waybar.css`, importados pelo `style.css`.
- `preview/bar.png` — captura da barra.

`config` e scripts sao iguais nas duas; o que muda e o `style.css` (fundos translucidos e texto sobre o destaque) e o `state/colors.css` (accent `#8caaee` no dark, `#1e66f5` no light).

## Instalar (troque `dark` por `light`)
```bash
V=dark
mkdir -p ~/.config/waybar ~/.local/state/hakuspace/theme/opaque ~/.local/bin
cp -r $V/waybar/* ~/.config/waybar/
cp $V/state/colors.css $V/state/fonts.css ~/.local/state/hakuspace/theme/
cp $V/state/opaque/waybar.css ~/.local/state/hakuspace/theme/opaque/
install -m755 $V/scripts/* ~/.local/bin/
sudo install -m755 $V/scripts/waybar-loop /usr/local/bin/waybar-loop   # e no autostart do mango: exec_once=waybar-loop
```
Trocar de variante sem reiniciar: copie o `style.css` e o `colors.css` da outra e rode `pkill -SIGUSR2 waybar` (no mango: bind `SUPER,F12`).

## Notas
- O `config` usa caminhos `$HOME/.config/waybar/module/...` e `$HOME/.local/bin/...`.
- Layout do mango: `S` scroller, `T` tile, `G` grid, `M` monocle (abas), `K` deck (empilhado) etc.; rolar o mouse sobre o indicador alterna, clicar abre o menu.
- Se a waybar cair no login (portal D-Bus lento), use o `waybar-loop`.
- A variante `light` foi gerada trocando a paleta; o tooltip do calendario mantem as cores do `config`.
