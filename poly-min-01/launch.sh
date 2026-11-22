#!/bin/sh
# poly-min-01: fecha o polybar anterior e abre este (chamar no startupHook do xmonad ou num atalho)
pkill -x polybar; while pgrep -x polybar >/dev/null; do sleep 0.1; done
exec polybar -q -c "$HOME/.config/polybar/poly-min-01/config.ini" poly-min-01
