-- hypr3 binds — mainMod = ALT; workspaces on SUPER

local home = os.getenv("HOME") or "~"
local mainMod = "ALT"
local scripts = home .. "/.config/hypr3/scripts"

local function bind(combo, dispatcher, description, opts)
  opts = opts or {}
  if description then opts.description = description end
  hl.bind(combo, dispatcher, opts)
end

local function exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

-- Apps (requested)
bind(mainMod .. " + D", exec("pkill rofi 2>/dev/null; rofi -show drun -no-lazy-grab -config " .. home .. "/.config/hypr3/rofi/config.rasi"), "rofi drun")
bind(mainMod .. " + Return", exec("foot"), "terminal")
bind(mainMod .. " + W", exec("firefox"), "firefox")
bind(mainMod .. " + X", exec(scripts .. "/Wlogout.sh"), "wlogout")
bind(mainMod .. " + E", exec("thunar"), "file manager")
bind(mainMod .. " + Q", hl.dsp.window.close(), "close window")
bind(mainMod .. " + F", hl.dsp.window.fullscreen(), "fullscreen")
bind(mainMod .. " + F12", exec(scripts .. "/RefreshWaybar.sh"), "refresh waybar")

-- Essentials
bind(mainMod .. " + C", hl.dsp.window.kill(), "kill window")
bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), "toggle float")
bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }), "focus down")
bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }), "focus up")
bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }), "focus left")
bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }), "focus right")
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), "drag", { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), "resize", { mouse = true })

-- Workspaces on SUPER (as in hypr2)
for i = 1, 10 do
  local key = i == 10 and 0 or i
  bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }), "workspace " .. i)
  bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), "move to workspace " .. i)
end
bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "next workspace")
bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), "previous workspace")
