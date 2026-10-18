-- ──────────────────────────────────────────────
--   Hyprland Configuration — Lua (0.55+)
--   Migrated from hyprland.conf · Intel Celeron N4020 · UHD 600 · 8 GB RAM
--   Preserves all original semantics; theme delegated to theme.lua/colors.lua
--   See wiki.hypr.land + /usr/share/hypr/stubs/hl.meta.lua for API details
-- ──────────────────────────────────────────────

local HOME = os.getenv("HOME")

local function theme_dir()
	local src = debug.getinfo(1, "S").source
	if src:sub(1, 1) == "@" then
		src = src:sub(2)
	end
	local dir = src:match("(.*/)") or (HOME .. "/.config/hypr/")

	local handle = io.popen("readlink -f " .. string.format("%q", src) .. " 2>/dev/null")
	if handle then
		local resolved = handle:read("*a"):gsub("%s+$", "")
		handle:close()
		if resolved ~= "" then
			local resolved_dir = resolved:match("(.*/)")
			if resolved_dir then
				dir = resolved_dir
			end
		end
	end

	-- Self-contained theme: never fall back to another theme's configs/ tree.
	return dir
end

-- Read the shared path registry without launching any applications.
local function shell_quote(value)
	return "'" .. value:gsub("'", "'\"'\"'") .. "'"
end
local registry = theme_dir() .. "theme-paths.sh"
local path_reader = assert(
	io.popen(
		"bash -c "
			.. shell_quote('source "$1" || exit 1; printf "%s\\n" "$THEME_DIR" "$HYPR_ENV_FILE"')
			.. " bash "
			.. shell_quote(registry)
	)
)
local path_output = path_reader:read("*a") or ""
path_reader:close()
local resolved_root, env_file = path_output:match("^([^\n]+)\n([^\n]+)\n$")
assert(resolved_root and env_file, "Cannot load theme-paths.sh: " .. path_output)
THEME_DIR = resolved_root .. "/"

USER_DIR = THEME_DIR .. "user/"
ARCHCRAFT_DIR = THEME_DIR .. "Archcraft/"

function theme_path(rel)
	local userp = USER_DIR .. rel
	local f = io.open(userp, "r")
	if f then
		f:close()
		return userp
	end
	local archp = ARCHCRAFT_DIR .. rel
	f = io.open(archp, "r")
	if f then
		f:close()
		return archp
	end
	return THEME_DIR .. rel
end

SCRIPTS_DIR = theme_path("scripts/")
WAYBAR_DIR = theme_path("waybar/")
ROFI_DIR = theme_path("rofi/")

-- ── Monitor ──────────────────────────────────
local function apply_monitors()
	local path = THEME_DIR .. "monitors.conf"
	local file = io.open(path, "r")
	if not file then
		hl.monitor({ output = "Virtual-1", mode = "", position = "0x0", scale = 1 })
		return
	end

	local applied = false
	for line in file:lines() do
		local spec = line:match("^monitor=(.+)$")
		if spec then
			local output, mode, position, scale = spec:match("^([^,]+),([^,]+),([^,]+),([^,]+)$")
			if output then
				if mode == "preferred" then
					mode = ""
				end
				if position == "auto" then
					position = "0x0"
				end
				hl.monitor({
					output = output,
					mode = mode,
					position = position,
					scale = tonumber(scale) or 1,
				})
				applied = true
			end
		end
	end
	file:close()

	if not applied then
		hl.monitor({ output = "Virtual-1", mode = "", position = "0x0", scale = 1 })
	end
end

apply_monitors()

-- ── Environment ──────────────────────────────
hl.env("XCURSOR_SIZE", "20")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Env externo tem que ser depois de direct_scanout

-- ── Default Programs ─────────────────────────
local terminal = "foot"
local browser = "brave"
local menu = "rofi -no-config -show drun -show-icons -theme " .. shell_quote(ROFI_DIR .. "selectors.rasi")
local file = "thunar"

-- ── Input ────────────────────────────────────
hl.config({
	input = {
		kb_layout = "br",
		kb_variant = "abnt2",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
		},
	},
})

-- ── Theme (was: source = ~/.config/hypr/colors.conf / theme.conf) ──
-- In 0.55 `source` → `require("module")`. Each file shares the `hl` global.
-- Keep both hyprlang .conf and new Lua .lua on disk for rollback; Lua wins when present.
-- Matugen now writes colors.lua (see matugen/templates/hyprland.lua); theme.lua is a
-- symlink to the active theme in hypr/themes/*/theme.lua (managed by theme-selector.sh)
dofile(THEME_DIR .. "colors.lua")
dofile(THEME_DIR .. "theme.lua")

-- ── Autostart (was exec-once) ────────────────
hl.on("hyprland.start", function()
	hl.exec_cmd(shell_quote(SCRIPTS_DIR .. "WallpaperDaemon.sh"))
	hl.exec_cmd(shell_quote(SCRIPTS_DIR .. "start-waybar.sh"))
	hl.exec_cmd("dunst")
	hl.exec_cmd(terminal)
end)

-- ── Animations ───────────────────────────────
hl.config({
	animations = {
		enabled = false,
	},
})
-- Bezier (was inside animations { bezier = ... })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
-- Animations per leaf (were: animation = windows, 1, 3, easeOutExpo, popin 80% etc.)
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOutExpo", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeOutExpo", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "easeOutExpo" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutExpo", style = "slide" })

-- ── Layouts ──────────────────────────────────
hl.config({
	dwindle = {
		-- pseudotile removed in 0.55 (use window rule or dispatcher `pseudo` instead)
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
})

-- ── Misc / Render / Debug ────────────────────
hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = false,
		initial_workspace_tracking = false,
	},
	render = {
		direct_scanout = true, -- was misc.no_direct_scanout (inverted)
	},
	debug = {
		disable_logs = true,
		-- vfr moved here from misc.vfr (0.55)
		vfr = true,
	},
})

dofile(env_file)

-- ── Keybinds ─────────────────────────────────
local mod = "SUPER"
local mon = shell_quote(HOME .. "/.local/bin/mon") .. " --hypr"
--local logout = shell_quote(SCRIPTS_DIR .. "Wlogout.sh")
local logout = shell_quote(WAYBAR_DIR .. "/scripts/power-menu.sh")

local function bind_apps(modifier)
	hl.bind(modifier .. " + W", hl.dsp.exec_cmd("firefox"))
	hl.bind(modifier .. " + E", hl.dsp.exec_cmd(file))
	hl.bind(modifier .. " + Return", hl.dsp.exec_cmd(terminal))
	hl.bind(modifier .. " + X", hl.dsp.exec_cmd(logout))
	hl.bind(modifier .. " + M", hl.dsp.exec_cmd(mon))
	hl.bind(modifier .. " + D", hl.dsp.exec_cmd(menu))
end

bind_apps("SUPER")
bind_apps("ALT")

-- Default programs
-- App binds are grouped below for Super and Alt.
-- Rofi is included in the shared app binds below.
hl.bind(mod .. " + SHIFT + X", hl.dsp.exec_cmd(shell_quote(WAYBAR_DIR .. "scripts/power-menu.sh")))
hl.bind(mod .. " + Q", hl.dsp.window.close()) -- was killactive (graceful close)
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen()) -- was fullscreen, 0
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- togglefloating
hl.bind(mod .. " + P", hl.dsp.window.pseudo()) -- pseudo
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit")) -- togglesplit (layoutmsg)
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
-- Thunar is included in the shared app binds below.
--hl.bind(mod .. " + C", hl.dsp.exec_cmd("libreoffice --writer"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(shell_quote(SCRIPTS_DIR .. "wall-selector.sh")))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(shell_quote(SCRIPTS_DIR .. "random-wall.sh")))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd(shell_quote(SCRIPTS_DIR .. "waybar-selector.sh")))
hl.bind(mod .. " + SHIFT + T", hl.dsp.exec_cmd(shell_quote(SCRIPTS_DIR .. "global-theme-selector.sh")))
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd(shell_quote(SCRIPTS_DIR .. "hypr-monitor-toggle.sh")))

-- Move focus (Vim-style)
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Resize windows (Arrow keys) — binde → { repeating = true }
hl.bind(mod .. " + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mod .. " + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Switch workspaces (was 9 explicit binds — loop is idiomatic Lua, same effect)
for i = 1, 9 do
	hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move active window to workspace
for i = 1, 9 do
	hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces (mouse wheel)
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse (was bindm)
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume & brightness (media keys) — bindel/bindl → { repeating, locked }
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { repeating = true, locked = true })

-- Screenshot (requires grim + slurp)
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd("grim - | wl-copy"))

-- ── Window Rules ─────────────────────────────
hl.window_rule({
	name = "suppress-maximize",
	match = { class = ".*" },
	suppress_event = "maximize",
})
