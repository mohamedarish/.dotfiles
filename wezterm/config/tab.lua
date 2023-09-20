local wezterm = require("wezterm")

local function apply_tab_config(config)
	config.hide_tab_bar_if_only_one_tab = true
	config.window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled
		-- with wezterm.
		-- Whatever font is selected here, it will have the
		-- main font setting appended to it to pick up any
		-- fallback fonts you may have used there.
		font = wezterm.font({ family = "CaskaydiaCove Nerd Font", weight = "Bold" }),

		-- The size of the font in the tab bar.
		-- Default to 10. on Windows but 12.0 on other systems
		font_size = 14.0,

		-- The overall background color of the tab bar when
		-- the window is focused
		active_titlebar_bg = "1D2D3E",

		-- The overall background color of the tab bar when
		-- the window is not focused
		inactive_titlebar_bg = "#5B738B",
	}
	config.colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			inactive_tab_edge = "#e5e5e5",
		},
	}
	config.tab_bar_at_bottom = false
end

return apply_tab_config
