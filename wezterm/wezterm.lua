local background = require("config/background")
local font = require("config/font")
local colorscheme = require("config/colorscheme")
local tab = require("config/tab")
local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

background(config)
font(config)
colorscheme(config)
tab(config)
config.default_cursor_style = "BlinkingBar"

return config
