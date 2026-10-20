#!/usr/bin/env bash
set -euo pipefail

action=
target=${WLOGOUT_SESSION_TARGET:-auto}
for arg in "$@"; do
  case "$arg" in
    --serpantinum) target=serpantinum ;;
    --niri) target=niri ;;
    --hypr_lua) target=hypr_lua ;;
    --hypr_conf) target=hypr_conf ;;
    lock|logout)
      if [[ -n "$action" ]]; then
        echo 'Informe uma única ação: lock ou logout' >&2
        exit 2
      fi
      action=$arg
      ;;
    *)
      echo 'Uso: session-action.sh [--serpantinum|--niri|--hypr_lua|--hypr_conf] <lock|logout>' >&2
      exit 2
      ;;
  esac
done
if [[ -z "$action" ]]; then
  echo 'Uso: session-action.sh [--serpantinum|--niri|--hypr_lua|--hypr_conf] <lock|logout>' >&2
  exit 2
fi

desktop=$(printf '%s %s' "${XDG_CURRENT_DESKTOP:-}" "${XDG_SESSION_DESKTOP:-}" | tr '[:upper:]' '[:lower:]')
session_id=${XDG_SESSION_ID:-}

case "$action" in
  lock)
    if [[ -z "$session_id" ]]; then
      session_id=$(loginctl show-seat seat0 -p ActiveSession --value)
    fi
    [[ -n "$session_id" ]] || exit 1
    exec loginctl lock-session "$session_id"
    ;;
  logout)
    case "$target" in
      serpantinum)
        if command -v serpantinum >/dev/null 2>&1; then
          exec serpantinum exit
        fi
        exec niri msg action quit --skip-confirmation
        ;;
      niri)
        exec niri msg action quit --skip-confirmation
        ;;
      hypr_lua|hypr_conf)
        exec hyprctl dispatch exit
        ;;
      auto)
        if [[ -n "${NIRI_SOCKET:-}" || "$desktop" == *niri* || "$desktop" == *serpantinum* ]]; then
          if command -v serpantinum >/dev/null 2>&1; then
            exec serpantinum exit
          fi
          exec niri msg action quit --skip-confirmation
        fi
        if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" || "$desktop" == *hyprland* ]]; then
          exec hyprctl dispatch exit
        fi
        if [[ "$desktop" == *gnome* ]] && command -v gnome-session-quit >/dev/null 2>&1; then
          exec gnome-session-quit --logout --no-prompt
        fi
        ;;
    esac
    if [[ -z "$session_id" ]]; then
      session_id=$(loginctl show-seat seat0 -p ActiveSession --value)
    fi
    [[ -n "$session_id" ]] || exit 1
    exec loginctl terminate-session "$session_id"
    ;;
esac
