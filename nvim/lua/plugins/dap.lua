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
			-- dap.lua
			local dap, dapui = require("dap"), require("dapui")

			-- 1. 适配器配置
			dap.adapters.delve = function(callback, config)
				local port = 38697
				callback({
					type = "server",
					port = port,
					executable = {
						command = "dlv",
						args = { "dap", "-l", "127.0.0.1:" .. port },
					},
					options = {
						outputMode = "remote", -- 关键配置
					},
				})
			end

			-- plugins/dap.lua
			dap.configurations.go = {
				-- ============ 调试可执行程序 ============
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
					name = "Debug Workspace",
					request = "launch",
					program = "${workspaceFolder}",
				},

				-- ============ 调试测试 ============
				-- 注意：这个配置只在 _test.go 文件中可用
				{
					type = "delve",
					name = "Debug test (current package)",
					request = "launch",
					mode = "test",
					program = "${fileDirname}",
				},
				-- 带参数的测试
				{
					type = "delve",
					name = "Debug test with args",
					request = "launch",
					mode = "test",
					program = "${fileDirname}",
					args = { "-test.v", "-test.run", "TestMyFunction" },
				},
				-- 调试当前文件下的所有测试（包括子包）
				{
					type = "delve",
					name = "Debug all tests",
					request = "launch",
					mode = "test",
					program = "./...",
					cwd = "${workspaceFolder}",
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
			-- dap.configurations.go = {
			-- 	{
			-- 		type = "delve",
			-- 		name = "Debug file",
			-- 		request = "launch",
			-- 		program = "${file}",
			-- 	},
			-- 	{
			-- 		type = "delve",
			-- 		name = "Debug Package",
			-- 		request = "launch",
			-- 		program = "${fileDirname}",
			-- 	},
			-- 	{
			-- 		type = "delve",
			-- 		name = "Debug Workspace (go.mod)",
			-- 		request = "launch",
			-- 		program = "${workspaceFolder}",
			-- 	},
			-- 	{
			-- 		type = "delve",
			-- 		name = "Debug test", -- configuration for debugging test files
			-- 		request = "launch",
			-- 		mode = "test",
			-- 		program = "${file}",
			-- 	},
			-- 	-- works with go.mod packages and sub packages
			-- 	{
			-- 		type = "delve",
			-- 		name = "Debug test (go.mod)",
			-- 		request = "launch",
			-- 		mode = "test",
			-- 		program = "./${relativeFileDirname}",
			-- 	},
			dapui.setup(dapui_opt)

			-- 5. 虚拟文本
			require("nvim-dap-virtual-text").setup({
				commented = true,
				virt_text_pos = "eol", -- 显示在行尾，更清晰
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				-- 在当前代码 buffer 中设置临时映射
				local bufnr = vim.api.nvim_get_current_buf()
				require("keymap").DAPTmpmap(bufnr) -- 传入 bufnr

				-- 打开 dapui
				vim.defer_fn(function()
					require("dapui").open({})
				end, 100)
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close({})
				-- 不需要 DAPTmpunmap！buffer 销毁时映射自动清除
				local ok, api = pcall(require, "nvim-tree.api")
				if ok then
					api.tree.close()
				end
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close({})
				-- 同样不需要 unmap
				local ok, api = pcall(require, "nvim-tree.api")
				if ok then
					api.tree.close()
				end
			end

			require("keymap").DAPmap()
			--不能针对某个buffer设置起属性,因为代码不会在一个文件中写,
			--解决方案
			--通常设置一批映射关系
			--检测dap开启,覆盖这批映射关系
			--检测dap关闭,删除关闭这批dap映射关系,并且还原普通的映射关系

			-- dap.listeners.before.attach.dapui_config = function()
			-- 	print("dapui_config")
			-- 	require("keymap").DAPTmpmap()
			-- 	dapui.open({})
			-- end
			--
			-- dap.listeners.before.launch.dapui_config = function()
			-- 	print("dapui_config1")
			-- 	require("keymap").DAPTmpmap()
			-- 	dapui.open({})
			-- end
			--
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	print("dapui_config2")
			-- 	require("keymap").DAPTmpunmap()
			-- 	dapui.close({})
			-- 	local status_ok, api = pcall(require, "nvim-tree.api")
			-- 	if status_ok then
			-- 		api.tree.close()
			-- 		return
			-- 	end
			-- end
			--
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	print("dapui_config2")
			-- 	require("keymap").DAPTmpunmap()
			-- 	dapui.close({})
			-- end
			--
			-- require("nvim-dap-virtual-text").setup({
			-- 	commented = true,
			-- })
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
