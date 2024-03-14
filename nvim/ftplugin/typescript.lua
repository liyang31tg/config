local tmp_group_typescript = vim.api.nvim_create_augroup("ftplugin_typescript", { clear = true })
print("vim.api.nvim_create_autocmd typescript")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	group = tmp_group_typescript,
	callback = function(args)
		-- vim.keymap.set("n", "<LocalLeader>a", "<cmd>!node %<cr>", { buffer = args.buf, desc = "run javascript" })
	end,
})
