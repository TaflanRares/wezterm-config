local wezterm = require("wezterm")
local keys    = require("keys")
local mouse   = require("mouse")
local tabs    = require("tabs")
local config  = wezterm.config_builder()

local temp_path = "C:/Users/tafla/AppData/Local/Temp/WezTemp"

config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }

config.set_environment_variables = {
  ["TEMP"] = temp_path,
  ["TMP"] = temp_path,
  ["TMPDIR"] = temp_path,
  ["MSYS2_ARG_CONV_EXCL"] = "*",
}

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12
config.line_height = 1

config.color_scheme = "Dark+"

config.initial_cols = 120
config.initial_rows = 30

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

tabs.apply(config)

config.leader = { key = "w", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keys.keys

config.mouse_bindings = mouse.mouse_bindings

config.window_close_confirmation = "AlwaysPrompt"
config.exit_behavior = "Close"

wezterm.on("window-should-close", function(window)
  return tabs.is_nvim_running(window)
end)

return config
