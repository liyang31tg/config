local tmp_group = vim.api.nvim_create_augroup("ftplugin_javascript", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*", --这里可以通配,因为外面已经有filetype过滤了
	group = tmp_group,
	callback = function(args)
		-- vim.keymap.set("n", ",r", "<cmd>!node %<cr>", { desc = "run javascript" })
	end,
})
