local wezterm = require("wezterm")

local function apply_font(config)
	config.font_size = 16.0
	config.font = wezterm.font({
		family = "CaskaydiaCove Nerd Font",
		weight = "Regular",
	})
end

return apply_font
