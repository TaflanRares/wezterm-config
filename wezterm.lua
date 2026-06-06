local wezterm = require("wezterm")
local keys    = require("keys")
local mouse   = require("mouse")
local tabs    = require("tabs")
local config  = wezterm.config_builder()

-- shell
config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }

-- font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12
config.line_height = 1

-- colors
config.color_scheme = "Dark+"

-- window
config.initial_cols = 120
config.initial_rows = 30

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tabs
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
tabs.apply(config)

-- keys
config.leader = { key = "w", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keys.keys

-- mouse
config.mouse_bindings = mouse.mouse_bindings

return config
