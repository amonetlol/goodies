#!/usr/bin/env bash
source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../../theme-paths.sh" || exit 1
# Use the same selector and explicit config paths as the Hyprland shortcut.
exec "$SCRIPTS_DIR/waybar-selector.sh" "$@"
