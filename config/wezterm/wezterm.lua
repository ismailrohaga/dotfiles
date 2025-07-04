local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.keys = {
	-- This will create a new horizontal split (ALT+s)
	{
		key = "s",
		mods = "ALT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- This will create a new vertical split (ALT+s)
	{
		key = "v",
		mods = "ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- This will close the current pane (ALT+w)
	{
		key = "w",
		mods = "ALT",
		action = act.CloseCurrentPane({ confirm = true }),
	},

	-- Directional navigation
	{ key = "H", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "J", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "K", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "L", mods = "ALT", action = act.ActivatePaneDirection("Right") },

	-- Adjust pane size
	{
		key = "LeftArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
}

return config
