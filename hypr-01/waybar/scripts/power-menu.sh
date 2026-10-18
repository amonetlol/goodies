#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../../theme-paths.sh" || exit 1
# ──────────────────────────────────────────────
#   Power / Controls Menu for Waybar
# ──────────────────────────────────────────────

# Use active theme script style
THEME="$ROFI_DIR/selectors.rasi"
DIVIDER="────────────────────────────"

# Position is defined by the local Rofi theme (top bar).
ROFI_ARGS=""

# ── Build menu ───────────────────────────────
build_menu() {
    echo "󰌾  Lock"
    echo "󰍃  Logout"
    echo "󰤄  Suspend"
    echo "󰜉  Reboot"
    echo "󰐥  Shutdown"
}

# ── Handle selection ─────────────────────────
handle_selection() {
    local choice="$1"

    case "$choice" in
        "󰌾  Lock")
            hyprlock & ;;

        "󰍃  Logout")
            hyprctl dispatch 'hl.dsp.exit()' 2>/dev/null \
                || hyprctl dispatch exit 2>/dev/null ;;

        "󰤄  Suspend")
            systemctl suspend ;;

        "󰜉  Reboot")
            systemctl reboot ;;

        "󰐥  Shutdown")
            systemctl poweroff ;;
    esac
}

# ── Main ─────────────────────────────────────
main() {
    local menu
    menu=$(build_menu)

    local choice
    choice=$(echo "$menu" | rofi -no-config -dmenu $ROFI_ARGS -p "  Controls" -theme "$THEME" -i)

    [[ -z "$choice" ]] && exit 0

    handle_selection "$choice"
}

main
