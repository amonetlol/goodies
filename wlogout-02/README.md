# Wlogout 02 — Vora
Lock, Logout, Suspend, Reboot e Shutdown, nessa ordem.
Execute `bash launch.sh`. Requer wlogout, swaylock, Hyprland e systemd.
Ícones e configuração do bloqueio incluídos.
Logout usa `hyprctl eval 'hl.dispatch(hl.dsp.exit())'`, compatível com o Hyprland Lua da Vora.
Suspend, Reboot e Shutdown usam `systemctl`; Lock usa a configuração local do swaylock.
