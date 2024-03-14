local tmp_group_go = vim.api.nvim_create_augroup("ftplugin_g", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	group = tmp_group_go,
	callback = function(args)
		-- vim.keymap.set("n", "<LocalLeader>a", "<cmd>!node %<cr>", { buffer = args.buf, desc = "run javascript" })
	end,
})
