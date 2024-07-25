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
				"scopes",
				"stacks",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"breakpoints",
				"watches",
			},
			size = 40,
			position = "right",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 12,
			position = "bottom",
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
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
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
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local vscode = require("dap.ext.vscode")
			-- local json = require("plenary.json")
			-- vscode.json_decode = function(str)
			-- 	return vim.json.decode(json.json_strip_comments(str, {}))
			-- end

			-- Extends dap.configurations with entries read from .vscode/launch.json
			if vim.fn.filereadable(".vscode/launch.json") then
				vscode.load_launchjs()
			end
			--官方文档copy
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output='dap'" },
				},
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			-- https://github.com/ravenxrz/dotfiles/blob/master/nvim/lua/user/dap/dap-util.lua
			-- Some variables are supported:
			-- `${file}`: Active filename
			-- `${fileBasename}`: The current file's basename
			-- `${fileBasenameNoExtension}`: The current file's basename without extension
			-- `${fileDirname}`: The current file's dirname
			-- `${fileExtname}`: The current file's extension
			-- `${relativeFile}`: The current file relative to |getcwd()|
			-- `${relativeFileDirname}`: The current file's dirname relative to |getcwd()|
			-- `${workspaceFolder}`: The current working directory of Neovim
			-- `${workspaceFolderBasename}`: The name of the folder opened in Neovim
			-- `${command:pickProcess}`: Open dialog to pick process using |vim.ui.select|
			-- `${env:Name}`: Environment variable named `Name`, for example: `${env:HOME}`.
			-- launch.json 中的一些写法
			-- {
			--     "version": "0.2.0",
			--     "configurations": [
			--         {
			--             "type": "delve",
			--             "name": "Debug",
			--             "request": "launch",
			--             "program": "${file}"
			--         },
			--         {
			--             "type": "delve",
			--             "name": "Debug test",
			--             "request": "launch",
			--             "mode": "test",
			--             "program": "${fileDirname}"
			--         },
			--         {
			--             "type": "delve",
			--             "name": "Debug test (go.mod)",
			--             "request": "launch",
			--             "mode": "test",
			--             "program": "./${relativeFileDirname}"
			--         }
			--     ]
			-- }

			-- 可以覆写,通过上面的launch.json来配置
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug file",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug Package",
					request = "launch",
					program = "${fileDirname}",
				},
				{
					type = "delve",
					name = "Debug Workspace (go.mod)",
					request = "launch",
					program = "${workspaceFolder}",
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}

			dapui.setup(dapui_opt)
			require("keybindings").DAPmap()
			--不能针对某个buffer设置起属性,因为代码不会在一个文件中写,
			--解决方案
			--通常设置一批映射关系
			--检测dap开启,覆盖这批映射关系
			--检测dap关闭,删除关闭这批dap映射关系,并且还原普通的映射关系

			dap.listeners.before.attach.dapui_config = function()
				print("dapui_config")
				require("keybindings").DAPTmpmap()
				dapui.open({})
			end

			dap.listeners.before.launch.dapui_config = function()
				print("dapui_config1")
				require("keybindings").DAPTmpmap()
				dapui.open({})
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				print("dapui_config2")
				require("keybindings").DAPTmpunmap()
				dapui.close({})
				local status_ok, api = pcall(require, "nvim-tree.api")
				if status_ok then
					api.tree.close()
					return
				end
			end

			dap.listeners.before.event_exited.dapui_config = function()
				print("dapui_config2")
				require("keybindings").DAPTmpunmap()
				dapui.close({})
			end

			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = "mason.nvim",
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				"go-debug-adapter",
				-- Update this to ensure that you have the debuggers for the langs you want
			},
		},
		-- mason-nvim-dap is loaded when nvim-dap loads
		config = function() end,
	},
}
return obj
