#!/usr/bin/env bash
source "$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")/../../theme-paths.sh" || exit 1

# Perfis: Default (maquina fisica) ou VMware (sem Bluetooth/backlight).
PROFILE="VMware"
case "$PROFILE" in Default|VMware) ;; *) echo "Perfil invalido: $PROFILE" >&2; exit 1 ;; esac
THEME="$WAYBAR_DIR/scripts/control-center.rasi"

get_wifi() {
    local ssid
    ssid=$(timeout 2 nmcli -t -f active,ssid dev wifi 2>/dev/null | sed -n 's/^yes://p' | head -n 1)
    printf '%s' "${ssid:-Sem conexao Wi-Fi}"
}

get_volume() {
    local value
    if command -v wpctl >/dev/null; then
        value=$(LC_ALL=C timeout 2 wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
        if [[ "$value" == *MUTED* ]]; then printf 'Mudo'; return; fi
        [[ "$value" == Volume:* ]] && { awk '{printf "%.0f%%", $2 * 100}' <<< "$value"; return; }
    elif command -v pactl >/dev/null; then
        value=$(LC_ALL=C timeout 2 pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null)
        value=$(grep -oE '[0-9]+%' <<< "$value" | head -n 1)
        [[ -n "$value" ]] && { printf '%s' "$value"; return; }
    elif command -v pamixer >/dev/null; then
        value=$(timeout 2 pamixer --get-volume-human 2>/dev/null)
        [[ -n "$value" ]] && { printf '%s' "$value"; return; }
    fi
    printf 'Indisponivel'
}

get_bluetooth() {
    local status
    if ! compgen -G '/sys/class/bluetooth/hci*' >/dev/null; then printf 'Sem adaptador'; return; fi
    status=$(timeout 2 bluetoothctl show 2>/dev/null)
    if [[ "$status" == *'Powered: yes'* ]]; then printf 'Ligado'; else printf 'Desligado'; fi
}

get_brightness() {
    local cur max
    if ! compgen -G '/sys/class/backlight/*' >/dev/null; then printf 'Indisponivel'; return; fi
    cur=$(timeout 2 brightnessctl -c backlight g 2>/dev/null)
    max=$(timeout 2 brightnessctl -c backlight m 2>/dev/null)
    if [[ "$cur" =~ ^[0-9]+$ && "$max" =~ ^[0-9]+$ ]] && (( max > 0 )); then
        printf '%s%%' "$((cur * 100 / max))"
    else printf 'Indisponivel'; fi
}

# Cada linha corresponde a uma acao; estados nao viram itens separados.
# Focus/Mirroring/Music do script antigo eram placeholders sem acao.
labels=("󰖩  Wi-Fi     |  $(get_wifi)")
actions=(wifi)
if [[ "$PROFILE" == Default ]]; then
    labels+=("󰂯  Bluetooth |  $(get_bluetooth)" "󰃠  Brilho    |  $(get_brightness)")
    actions+=(bluetooth brightness)
fi
labels+=("󰕾  Audio     |  $(get_volume)" "⏻  Energia   |  Opcoes da sessao")
actions+=(audio power)

choice=$(printf '%s\n' "${labels[@]}" | rofi -no-config -dmenu -no-custom -format i -i \
    -p "Control Center" -mesg "$PROFILE" -theme "$THEME") || exit 0
[[ "$choice" =~ ^[0-9]+$ ]] || exit 0
(( choice < ${#actions[@]} )) || exit 0
case "${actions[$choice]}" in
    wifi) "$WAYBAR_DIR/scripts/wifi-menu.sh" ;;
    bluetooth) "$WAYBAR_DIR/scripts/bluetooth-menu.sh" ;;
    brightness)
        if compgen -G '/sys/class/backlight/*' >/dev/null; then
            brightnessctl -c backlight set +10%
        else notify-send "Control Center" "Nenhum dispositivo de brilho disponivel"; fi ;;
    audio) pavucontrol ;;
    power) "$WAYBAR_DIR/scripts/power-menu.sh" ;;
esac
