#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../theme-paths.sh" || exit 1
# ──────────────────────────────────────────────
#   Generate Brave Chrome Theme from Matugen Colors
# ──────────────────────────────────────────────

SCRIPT_DIR="$SCRIPTS_DIR"

THEME_DIR_BRAVE="$HOME/.config/brave-theme"
COLORS_FILE="$ROFI_DIR/colors.rasi"

get_color() {
    grep "$1" "$COLORS_FILE" | grep -oP '#[0-9a-fA-F]{6}' | head -1
}

hex_to_rgb() {
    local hex="${1#\#}"
    printf "%d, %d, %d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

BG=$(get_color "background:")
BG_ALT=$(get_color "background-alt:")
FG=$(get_color "foreground:")
ACCENT=$(get_color "selected:")

BG_RGB=$(hex_to_rgb "$BG")
BG_ALT_RGB=$(hex_to_rgb "$BG_ALT")
FG_RGB=$(hex_to_rgb "$FG")
ACCENT_RGB=$(hex_to_rgb "$ACCENT")

mkdir -p "$THEME_DIR_BRAVE"

cat > "$THEME_DIR_BRAVE/manifest.json" << EOF
{
  "manifest_version": 3,
  "name": "Matugen Dynamic",
  "version": "1.0",
  "theme": {
    "colors": {
      "frame":                      [$BG_RGB],
      "frame_inactive":             [$BG_RGB],
      "frame_incognito":            [$BG_ALT_RGB],
      "frame_incognito_inactive":   [$BG_ALT_RGB],
      "toolbar":                    [$BG_ALT_RGB],
      "tab_background_inactive":    [$BG_RGB],
      "tab_background_active":      [$BG_ALT_RGB],
      "tab_text":                   [$FG_RGB],
      "bookmark_text":              [$FG_RGB],
      "ntp_background":             [$BG_RGB],
      "ntp_text":                   [$FG_RGB],
      "omnibox_background":         [$BG_RGB],
      "omnibox_text":               [$FG_RGB],
      "button_background":          [$ACCENT_RGB]
    },
    "tints": {
      "buttons":                    [0.5, 0.5, 0.8],
      "frame_incognito":            [0.5, 0.3, 0.5]
    }
  }
}
EOF

echo "Brave theme generated at $THEME_DIR_BRAVE/manifest.json"
