#!/usr/bin/env bash
source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
exec waybar -c "$WAYBAR_DIR/config.jsonc" -s "$(readlink -f -- "$WAYBAR_DIR/style.css")" "$@"
