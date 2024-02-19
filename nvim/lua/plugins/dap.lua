-- 定义各种图标
vim.fn.sign_define("DapBreakpoint", {
    text = "🔴",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
    -- text = "",
    text = "◎",
    -- text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
})

local dapui_opt = {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "o", "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                'scopes',
                'stacks',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'breakpoints',
                'watches',
            },
            size = 40,
            position = 'right',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 12,
            position = 'bottom',
        },
    },
    -- sidebar = {
    --   -- You can change the order of elements in the sidebar
    --   elements = {
    --     -- Provide as ID strings or tables with "id" and "size" keys
    --     {
    --       id = "scopes",
    --       size = 0.25, -- Can be float or integer > 1
    --     },
    --     { id = "breakpoints", size = 0.25 },
    --     { id = "stacks",      size = 0.25 },
    --     { id = "watches",     size = 0.25 },
    --   },
    --   size = 40,
    --   position = "left", -- Can be "left", "right", "top", "bottom"
    -- },
    -- tray = {
    --   elements = { "repl" },
    --   size = 10,
    --   position = "bottom", -- Can be "left", "right", "top", "bottom"
    -- },
    floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
}

local obj = {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text", --显示调试旁边的虚拟字体
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            --官方文档copy
            dap.adapters.delve = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}' },
                }
            }


            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            -- https://github.com/ravenxrz/dotfiles/blob/master/nvim/lua/user/dap/dap-util.lua
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}"
                },
                {
                    type = "delve",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}"
                },
                -- works with go.mod packages and sub packages
                {
                    type = "delve",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}"
                }
            }

            dapui.setup(dapui_opt)

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            require("nvim-dap-virtual-text").setup({
                commented = true,
            })

            -- 绑定 nvim-dap 快捷键
            require("keybindings").mapDAP()
        end
    },

}
return obj
