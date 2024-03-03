local M = {}

M.lazygit = {
	plugin = true,
	n = {
		["<leader>gg"] = {
			"<cmd> LazyGit <CR>",
			"Launch lazygit window",
		},
	},
}

return M
