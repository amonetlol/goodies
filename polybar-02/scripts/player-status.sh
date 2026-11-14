#!/usr/bin/env bash
# icone play/pause conforme o estado do player (playerctl)
s=$(playerctl status 2>/dev/null)
if [ "$s" = Playing ]; then printf '󰏤'; else printf '󰐊'; fi
