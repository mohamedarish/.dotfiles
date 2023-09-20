local M = {}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
        ["<leader>dus"] = {
            function()
                local widgets = require "dap.ui.widgets"
                local sidebar = widgets.sidebar(widgets.scopes)
                sidebar.open()
            end,
            "Open debugging sidebar",
        },
        ["<leader>dr"] = {
            "<cmd> DapContinue <CR>",
            "Start or continue the debugger",
        },
    },
}

M.dap_python = {
    plugin = true,
    n = {
        ["<leader>dpr"] = {
            function()
                require("dap-python").test_method()
            end,
            "Launch test debugger for python",
        },
    },
}

M.crates = {
    plugin = true,
    n = {
        ["<leader>rcu"] = {
            function()
                require("crates").upgrade_all_crates()
            end,
            "update crates",
        },
    },
}

M.lazygit = {
    plugin = true,
    n = {
        ["<leader>gg"] = {
            "<cmd> LazyGit <CR>",
            "Launch lazygit window",
        },
    },
}

M.rust_tools = {
    plugin = true,
    n = {
        ["<leader>rm"] = {
            "<cmd> RustExpandMacro <CR>",
            "Expand Macro",
        },
        ["<leader>rr"] = {
            "<cmd> RustHoverActions <CR>",
            "Rust Hover Actions",
        },
        ["<leader>rc"] = {
            "<cmd> RustCodeAction <CR>",
            "Rust Code Actions",
        },
        ["<leader>ru"] = {
            "<cmd> RustRunnables <CR>",
            "Rust Runnables",
        },
    },
}

return M
