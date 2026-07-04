local wezterm = require("wezterm")

local M = {}

function M.is_nvim_running(window)
	for _, tab_info in ipairs(window:mux_window():tabs_with_info()) do
		for _, p_info in ipairs(tab_info.tab:panes_with_info()) do
			local process = p_info.pane:get_foreground_process_name()
			if process and process:lower():match("nvim") then
				return true
			end
		end
	end
	return false
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane

	local success, process = pcall(function()
		return pane:get_foreground_process_name()
	end)

	process = (success and process) or ""

	local label = "terminal"
	local icon = ""

	if process:match("nvim") then
		label = "nvim"
		icon = ""
	elseif process:match("git") then
		label = "git"
		icon = ""
	elseif process:match("bash") or process:match("zsh") or process:match("sh") then
		label = "shell"
		icon = ""
	elseif process:match("python") then
		label = "python"
		icon = ""
	elseif process:match("node") then
		label = "node"
		icon = ""
	elseif process:match("cargo") or process:match("rust") then
		label = "rust"
		icon = ""
	elseif process:match("lua") then
		label = "lua"
		icon = ""
	end

	local text = "  " .. icon .. "    " .. label .. " "
	text = wezterm.truncate_right(text, max_width + 3)

	return {
		{ Text = text },
	}
end)

function M.apply(config)
	config.use_fancy_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = false

	config.colors = config.colors or {}

	config.colors.tab_bar = {
		background = "#1a1a1a",

		active_tab = {
			bg_color = "#3a3a3a",
			fg_color = "#ffffff",
		},

		inactive_tab = {
			bg_color = "#2a2a2a",
			fg_color = "#b0b0b0",
		},

		inactive_tab_hover = {
			bg_color = "#343434",
			fg_color = "#e0e0e0",
		},

		new_tab = {
			bg_color = "#2a2a2a",
			fg_color = "#b0b0b0",
		},

		inactive_tab_edge = "#2a2a2a",
	}
end

return M
