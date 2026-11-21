#!/usr/bin/env bash
# lista de atalhos (Super+F1) — OutTheme/Traffic; edite a LISTA com os atalhos do seu WM
cat <<'LIST' | rofi -dmenu -i -no-custom -p atalhos -mesg "atalhos do dwm  ·  digite para filtrar" -theme "$HOME/.config/rofi/rofi-top-01/hotkeys.rasi" >/dev/null
Super + Return / Alt + Return   │ kitty
Super + D / Alt + D             │ launcher (rofi)
Super + Shift + D               │ executar comando
Super + Shift + Tab             │ trocar janela (rofi)
Super + W / E                   │ firefox / nautilus
Super + X                       │ menu de energia
Super + ;                       │ menu de layouts
Super + F10                     │ escolher wallpaper
Super + F1                      │ esta lista
Super + Alt + T  (ou M)         │ btop
Super + Alt + V                 │ pwvucontrol
Super + I / Super + Alt + I     │ KVM: menu / alternar Void ⇄ PC
Super + Q                       │ fechar janela
Super + F                       │ maximizar (monocle liga/desliga)
Super + Shift + F               │ tela cheia
Super + T / C                   │ flutuar / centralizar
Super + Space                   │ próximo layout
Super + Ctrl + F1 / F2 / F3     │ layout tile / flutuante / monocle
Super + H / L                   │ largura do mestre
Super + O / Shift + O           │ + / − janelas no mestre
Super + setas · A S J K · Tab   │ foco (anterior / próxima)
Super + Shift + setas · J K     │ mover janela na pilha
Super + Shift + Return          │ janela para o mestre
Super + 1..0                    │ ir para a tag
Super + Shift + 1..0            │ mover janela para a tag
Super + Ctrl + 1..0             │ mostrar/ocultar tag junto
Super + PgDn / U · PgUp         │ tag próxima / anterior
Super + B                       │ mostrar/ocultar a barra
Super + arrastar (esq / dir)    │ mover / redimensionar janela
Print · Super/Alt + Print       │ captura região · tela / janela
Ctrl + Print                    │ flameshot
Super + Shift + E · Ctrl+Alt+Del│ sair do dwm
LIST
