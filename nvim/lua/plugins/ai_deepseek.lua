return {
	"yetone/avante.nvim",
	build = "make",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		instructions_file = "avante.md",
		-- 必须用 openai 兼容模式
		provider = "openai",
		auto_suggestions_provider = "openai",

		-- 新版强制要求写在这里
		providers = {
			openai = {
				endpoint = "https://api.deepseek.com/v1",
				model = "deepseek-coder",
				-- 优先使用 DEEPSEEK_API_KEY，如果不存在则使用 OPENAI_API_KEY
				api_key = os.getenv("DEEPSEEK_API_KEY") or os.getenv("OPENAI_API_KEY"),
				extra_request_body = {
					temperature = 0.7,
				},
			},
		},

		-- 快捷键保持不变
		mappings = {
			ask = "<leader>aa",
			edit = "<leader>ae",
			refresh = "<leader>ar",
			toggle = {
				debug = "<leader>ad",
				hint = "<leader>ah",
			},
			submit = {
				normal = "<S-CR>",
				insert = "<S-CR>",
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
