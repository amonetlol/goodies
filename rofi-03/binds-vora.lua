-- Preferência: amonetlol/ps binds-niri.txt; apps e demais opções: binds.txt.
local root = os.getenv("HOME") .. "/.config/hypr-vora"
local function run(key, command)
	hl.bind(key, hl.dsp.exec_cmd(command))
end
run("SUPER + RETURN", "$HOME/.config/hypr-vora/scripts/terminal")
run("SUPER + W", "firefox")
run("SUPER + E", "thunar")
run("SUPER + D", "$HOME/.config/hypr-vora/scripts/launcher")
run("SUPER + M", "$HOME/.local/bin/mon")
run("SUPER + X", "$HOME/.config/hypr-vora/scripts/power")
run("SUPER + H", "$HOME/.config/hypr-vora/scripts/settings")
run("SUPER + F10", "$HOME/.config/hypr-vora/scripts/wallpaper")
hl.bind("SUPER + Q", hl.dsp.window.close())
run("ALT + RETURN", "$HOME/.config/hypr-vora/scripts/terminal")
run("ALT + W", "firefox")
run("ALT + E", "thunar")
run("ALT + D", "$HOME/.config/hypr-vora/scripts/launcher")
run("ALT + M", "$HOME/.local/bin/mon")
run("ALT + X", "$HOME/.config/hypr-vora/scripts/power")
run("ALT + H", "$HOME/.config/hypr-vora/scripts/settings")
run("ALT + F10", "$HOME/.config/hypr-vora/scripts/wallpaper")
hl.bind("ALT + Q", hl.dsp.window.close())
run("SUPER + C", "$HOME/.config/hypr-vora/scripts/clipboard")
run("SUPER + F1", "$HOME/.config/hypr-vora/scripts/show-hotkeys")
run("SUPER + period", "$HOME/.config/hypr-vora/scripts/settings")
run("CTRL + SHIFT + R", "hyprctl reload")
run("SUPER + SHIFT + R", "hyprctl reload")
run("SUPER + F12", "$HOME/.config/hypr-vora/scripts/waybar-restart")
run("SUPER + ALT + T", "$HOME/.config/hypr-vora/scripts/terminal -e btop")
run("SUPER + SHIFT + L", "$HOME/.config/hypr-vora/scripts/lock")
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind("SUPER + SHIFT + P", hl.dsp.dpms({ action = "off" }))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + minus", hl.dsp.layout("colresize -0.1"))
hl.bind("SUPER + equal", hl.dsp.layout("colresize +0.1"))
hl.bind("SUPER + BackSpace", hl.dsp.layout("colresize -conf"))
hl.bind("SUPER + C", hl.dsp.layout("center"))
run("SUPER + Tab", "$HOME/.config/hypr-vora/scripts/windows")
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.layout("swapcol r"))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
run("Print", "$HOME/.config/hypr-vora/scripts/screenshot area")
run("CTRL + Print", "$HOME/.config/hypr-vora/scripts/screenshot screen")
run("ALT + Print", "$HOME/.config/hypr-vora/scripts/screenshot window")
run("SUPER + Print", "$HOME/.config/hypr-vora/scripts/screenshot area")
run("SUPER + SHIFT + S", "$HOME/.config/hypr-vora/scripts/screenshot save")
run("SUPER + SHIFT + A", "$HOME/.config/hypr-vora/scripts/screenshot edit")
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, repeating = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, repeating = true })

-- Atalhos adicionais compatíveis do repositório original.
run("SUPER + Space", "$HOME/.config/hypr-vora/scripts/launcher")
run("SUPER + SHIFT + C", "hyprctl reload")
run("SUPER + SHIFT + E", "$HOME/.config/hypr-vora/scripts/power")
hl.bind("SUPER + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + minus", hl.dsp.window.move({ workspace = "special:vora" }))

--[[
//---- DESATIVADOS ----
Originais Sway preservados para consulta. Duplicados seguem os binds amonetlol acima.
Ações exclusivas de Sway sem equivalente direto não são executadas.
bindsym $mod+Return exec $term
bindsym $mod+q kill
bindsym $mod+Space exec $menu
bindsym $mod+Shift+c reload
bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10
bindsym $mod+b splith
bindsym $mod+v splitv
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split
bindsym $mod+f fullscreen
bindsym $mod+Shift+space floating toggle
bindsym $mod+d focus mode_toggle
bindsym $mod+a focus parent
bindsym $mod+Shift+minus move scratchpad
bindsym $mod+minus scratchpad show
bindsym $left resize shrink width 10px
bindsym $down resize grow height 10px
bindsym $up resize shrink height 10px
bindsym $right resize grow width 10px
bindsym Left resize shrink width 10px
bindsym Down resize grow height 10px
bindsym Up resize shrink height 10px
bindsym Right resize grow width 10px
bindsym Return mode "default"
bindsym Escape mode "default"
bindsym $mod+r mode "resize"
bindsym $mod+Print exec ~/.config/sway/screenshot.sh area
bindsym $mod+Shift+s exec ~/.config/sway/screenshot.sh save
bindsym $mod+Shift+a exec ~/.config/sway/screenshot.sh edit
]]
