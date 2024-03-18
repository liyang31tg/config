vim.cmd([[
  autocmd TermOpen term://* startinsert
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " au BufNewFile,BufReadPost .zshrc_local,zshrc,zshrc setfiletype sh
]])

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "*.go" },
-- 	command = "silent! Format",
-- 	nested = true,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.cmd([[hi IlluminatedWordText ctermfg=Cyan guifg=#FF7373 gui=bold]])
vim.cmd([[hi IlluminatedWordRead ctermfg=Cyan guifg=#FF7373 gui=bold]])
vim.cmd([[hi IlluminatedWordWrite ctermfg=Cyan guifg=#FF7373 gui=bold]])
