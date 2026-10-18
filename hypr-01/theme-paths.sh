#!/usr/bin/env bash
# Fonte unica dos caminhos. Por padrao acompanha a localizacao deste arquivo.
# Para apontar a outra pasta, altere SOMENTE THEME_ROOT abaixo.
THEME_ROOT=""
_theme_paths_file="$(readlink -f -- "${BASH_SOURCE[0]}")" || return 1
THEME_DIR="${THEME_ROOT:-$(dirname -- "$_theme_paths_file")}" 
THEME_DIR="$(cd -- "$THEME_DIR" && pwd -P)" || return 1
SCRIPTS_DIR="$THEME_DIR/scripts"
WAYBAR_DIR="$THEME_DIR/waybar"
ROFI_DIR="$THEME_DIR/rofi"
HYPR_THEMES_DIR="$THEME_DIR/themes"
ARCHCRAFT_DIR="$THEME_DIR"
USER_DIR="$THEME_DIR"
# Recursos externos ao tema: ajuste aqui se tambem forem movidos.
HYPR_ENV_FILE="$THEME_DIR/env.lua"
MATUGEN_CONFIG="$HOME/.config/matugen/config.toml"
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Imagens/wallpapers}"
export THEME_DIR SCRIPTS_DIR WAYBAR_DIR ROFI_DIR HYPR_THEMES_DIR
export ARCHCRAFT_DIR USER_DIR HYPR_ENV_FILE MATUGEN_CONFIG WALLPAPER_DIR
unset _theme_paths_file
