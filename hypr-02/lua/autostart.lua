-- Autostart for hypr2 (standalone start-hyprland, no UWSM/graphical-session units).

local home = os.getenv("HOME") or "~"
local scriptsDir = home .. "/.config/hypr2/scripts"

local exec_once = {
  scriptsDir .. "/WallpaperDaemon.sh",
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP DESKTOP_SESSION XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE DISPLAY SSH_AUTH_SOCK",
  "gnome-keyring-daemon --start --components=secrets,ssh,pkcs11",
  "waybar",
  "foot",
}

hl.on("hyprland.start", function()
  for _, command in ipairs(exec_once) do
    hl.exec_cmd(command)
  end
end)
