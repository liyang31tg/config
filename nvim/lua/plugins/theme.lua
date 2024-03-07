local obj = {
	"glepnir/zephyr-nvim",
	config = function()
		-- vim.cmd([[ colorscheme zephyr ]])
		vim.cmd([[ colorscheme onenord ]])
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"rmehri01/onenord.nvim",
	},
}

return obj
