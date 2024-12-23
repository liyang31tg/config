local copilot_opts = {
	panel = {
		enabled = true,
		auto_refresh = true,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-CR>",
		},
		layout = {
			position = "bottom", -- | top | left | right | horizontal | vertical
			ratio = 0.4,
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		hide_during_completion = true,
		debounce = 75,
		keymap = {
			accept = "<TAB>",
			accept_word = false,
			accept_line = false,
			next = "<M-.>",
			prev = "<M-,>",
			dismiss = "<C-/>",
		},
	},
	filetypes = {
		go = true,
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
}
local copilot_chat_opts = {}
local obj = {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = copilot_chat_opts,
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			require("copilot").setup(copilot_opts)
			require("CopilotChat").setup(copilot_chat_opts)
		end,
	},
}
return obj
