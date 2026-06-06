local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },

  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },

  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },

  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "SHIFT",
    action = act.CopyTo("ClipboardAndPrimarySelection"),
  },
}

return M
