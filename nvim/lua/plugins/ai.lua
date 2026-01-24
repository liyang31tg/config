return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- 如果不固定版本，请确保拉取了最新代码
	opts = {
		-- 指定默认使用的 provider（这里仍然用 openai 兼容模式）
		provider = "openai",
		auto_suggestions_provider = "openai",

		-- [关键修改] 所有 openai 的配置现在必须放在 providers.openai 下
		providers = {
			openai = {
				-- https://chat.z.ai/ 智谱api的网页版
				endpoint = "https://open.bigmodel.cn/api/paas/v4",
				model = "glm-4.6",
				api_key = os.getenv("OPENAI_API_KEY"), --同时OPENAI_API_KEY设置同样的key
				-- 如果遇到模型不匹配的问题，可以尝试显式设置一下 parse_response
				-- parse_response_data = "glm4",
			},
		},

		-- 快捷键映射（保持不变）
		mappings = {
			ask = "<leader>aa",
			edit = "<leader>ae",
			refresh = "<leader>ar",
			toggle = {
				debug = "<leader>ad",
				hint = "<leader>ah",
			},
			submit = {
				normal = "<C-CR>", -- 在普通模式下提交（如果有侧边栏聚焦）
				insert = "<C-CR>", -- 在插入模式（输入框）下提交
			},
		},
	},
	-- 依赖项（保持不变）
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"HakonHarnes/img-clip.nvim",
		"MeanderingProgrammer/render-markdown.nvim",
	},
}
