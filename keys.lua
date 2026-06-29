local wezterm = require("wezterm")
local act = wezterm.action
local rmux = {}
local is_maximized = false

local function is_nvim(pane)
	local process = pane:get_foreground_process_name() or ""
	local title = pane:get_title() or ""

	return process:match("nvim") or title:match("nvim")
end

local function close_smart(window, pane)
	if is_nvim(pane) then
		window:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
	else
		window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
	end
end

rmux.keys = {
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action_callback(function(window, pane)
			local gui = window:mux_window():gui_window()

			if is_maximized then
				gui:restore()
				is_maximized = false
			else
				gui:maximize()
				is_maximized = true
			end
		end),
	},
	{
		mods = "LEADER",
		key = "c",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action_callback(close_smart),
	},
	{
		mods = "LEADER",
		key = "b",
		action = act.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = act.ActivateTabRelative(1),
	},

	{
		mods = "LEADER",
		key = "-",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},

	{
		mods = "LEADER",
		key = "h",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = act.ActivatePaneDirection("Down"),
	},

	{
		mods = "LEADER",
		key = "LeftArrow",
		action = act.AdjustPaneSize({ "Left", 10 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = act.AdjustPaneSize({ "Right", 10 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
}

return rmux
