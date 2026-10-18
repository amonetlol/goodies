#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
# Toggle Virtual-1 (VM) between preferred/auto and fixed 1920x1080@60

set -euo pipefail

SCRIPT_DIR="$SCRIPTS_DIR"

MONITOR="${MONITOR:-Virtual-1}"
FIXED_MODE="1920x1080@60"
CONFIG="${THEME_DIR}/monitors.conf"
LOCK_FILE="/tmp/hypr-monitor-toggle.lock"

notify() {
    if command -v dunstify >/dev/null 2>&1; then
        dunstify "$@" 2>/dev/null || true
    elif command -v notify-send >/dev/null 2>&1; then
        notify-send "$@" 2>/dev/null || true
    fi
}

detect_monitor() {
    if ! command -v hyprctl >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
        echo "hyprctl or jq not found" >&2
        return 1
    fi

    local detected
    detected=$(hyprctl monitors -j 2>/dev/null | jq -r --arg fallback "$MONITOR" '
        (.[] | select(.name == $fallback) | .name) //
        (.[0].name // empty)
    ')
    if [[ -n "$detected" ]]; then
        MONITOR="$detected"
    fi
}

is_fixed_mode() {
    local line=""
    if [[ -f "$CONFIG" ]]; then
        line=$(grep -E '^monitor=' "$CONFIG" | head -1 || true)
    fi

    if [[ "$line" == *"$FIXED_MODE"* ]]; then
        return 0
    fi
    if [[ "$line" == *"preferred"* ]]; then
        return 1
    fi

    # Fallback when config is missing or unreadable.
    local mode
    mode=$(hyprctl monitors -j 2>/dev/null | jq -r --arg m "$MONITOR" '.[] | select(.name == $m) | "\(.width)x\(.height)"')
    [[ "$mode" == "1920x1080" ]]
}

apply_monitor() {
    local lua_mode="$1"
    hyprctl eval "hl.monitor({ output = \"$MONITOR\", mode = \"$lua_mode\", position = \"0x0\", scale = 1 })"
}

persist_config() {
    printf 'monitor=%s\n' "$1" >"$CONFIG"
}

set_preferred() {
    local line="${MONITOR},preferred,auto,1"
    apply_monitor ""
    persist_config "$line"
    notify "Monitor $MONITOR" "Modo automático (preferred)"
}

set_fixed() {
    local line="${MONITOR},${FIXED_MODE},0x0,1"
    apply_monitor "$FIXED_MODE"
    persist_config "$line"
    notify "Monitor $MONITOR" "Modo fixo $FIXED_MODE"
}

toggle() {
    exec 9>"$LOCK_FILE"
    if ! flock -n 9; then
        exit 0
    fi

    detect_monitor

    if is_fixed_mode; then
        set_preferred
    else
        set_fixed
    fi
}

case "${1:-toggle}" in
    toggle) toggle ;;
    list) hyprctl monitors ;;
    *) echo "Usage: $0 [toggle|list]" ;;
esac
