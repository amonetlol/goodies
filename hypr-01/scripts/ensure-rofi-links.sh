#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
# Ensure rofi active theme symlinks exist (default: glass)
set -euo pipefail

SCRIPT_DIR="$SCRIPTS_DIR"
DEFAULT="${ROFI_DEFAULT_THEME:-glass}"

if [ ! -e "$ROFI_DIR/active-scripts.rasi" ]; then
    ln -sfn "themes/$DEFAULT/scripts.rasi" "$ROFI_DIR/active-scripts.rasi"
fi
if [ ! -e "$ROFI_DIR/active-launcher.rasi" ]; then
    ln -sfn "themes/$DEFAULT/launcher.rasi" "$ROFI_DIR/active-launcher.rasi"
fi

