vim.cmd([[
  autocmd TermOpen term://* startinsert
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " au BufNewFile,BufReadPost .zshrc_local,zshrc,zshrc setfiletype sh
]])

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.go" },
	command = "silent! Format",
	nested = true,
})
