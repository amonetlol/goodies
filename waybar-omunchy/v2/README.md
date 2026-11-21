# Waybar — Omunchy v2

Igual à v1, exceto o **botão de menu**: sem ícone, pílula com gradiente `cyan -> blue` (cantos 8px), igual ao workspace ativo do archcraft (`#workspaces button.visible`). Hover inverte o gradiente.

- `colors.css`: novos tokens `menu-from` `#5bc4bf` e `menu-to` `#06b6ef` (valores do archcraft; mude aqui para casar com o wallpaper).
- `style.css`: bloco `#custom-menu`.
- `config`: `custom/menu` usa só espaços Braille em branco como texto (waybar esconde módulo com texto vazio).

## Uso
```bash
cp -r waybar-omunchy/v2/* ~/.config/waybar/ && pkill -x waybar; waybar &
```
Preview: `preview.png` (montagem sobre o screenshot da v1; não é captura real da v2).

- Clima (`scripts/weather.sh`): sem configuração o wttr.in detecta a cidade pela rede; para fixar, `export WAYBAR_WEATHER_CITY=Sao+Paulo` (no ambiente da sessão).
