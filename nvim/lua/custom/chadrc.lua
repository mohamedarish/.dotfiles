---@type ChadrcConfig
local M = {}

M.ui = { theme = "vscode_dark" }
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

-- vim.o.expandtab = true
-- vim.o.tabstop = 4
-- vim.o.shiftwidth = 4

return M
