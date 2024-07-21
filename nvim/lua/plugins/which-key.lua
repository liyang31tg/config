local opt = {
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	-- ignore_missing = true,                                                     -- enable this to hide mappings for which you didn't specify a label
}
local obj = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"echasnovski/mini.icons",
	},
	opts = opt,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		local mappings = require("keybindings").whichkeys
		local wk = require("which-key")
		wk.add(mappings)
	end,
}

return obj
