-- Emerald / cyber-green theme

local accent = "rgb(94ef95)"   -- #5ef195
local accent2 = "rgb(a8ffd3)"  -- softer mint
local bg = "rgb(0a1414)"
local border_inactive = "rgb(1a2e2e)"

hl.config({
  general = {
    border_size = 2,
    gaps_in = 8,
    gaps_out = 14,
    col = {
      active_border = accent,
      inactive_border = border_inactive,
    },
    layout = "dwindle",
    resize_on_border = true,
  },
  decoration = {
    rounding = 12,
    active_opacity = 0.92,
    inactive_opacity = 0.88,
    fullscreen_opacity = 1.0,
    dim_inactive = false,
    shadow = { enabled = false },
    blur = {
      enabled = true,
      size = 8,
      passes = 3,
      new_optimizations = true,
      xray = true,
      ignore_opacity = true,
      special = true,
      popups = true,
    },
  },
  group = {
    col = { border_active = accent2 },
    groupbar = { col = { active = bg } },
  },
})
