#!/bin/sh
# poly-min-01, módulo "layout": ícone + nome do layout do xmonad (lido de _XMONAD_LOG na raiz do X, por eventos)
xprop -spy -root _XMONAD_LOG 2>/dev/null | while IFS= read -r l; do
  case "$l" in
    *'"Tile"'*)  echo "󰕰 Tile" ;;
    *'"Float"'*) echo "󰉈 Float" ;;
    *'"Full"'*)  echo "󰊓 Full" ;;
    *'= "'*)     echo "$l" | sed 's/^[^"]*"//; s/"$//' ;;
    *)           echo "󰕰 Tile" ;;
  esac
done
