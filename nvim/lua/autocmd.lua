vim.cmd([[
  autocmd TermOpen term://* startinsert
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " au BufNewFile,BufReadPost .zshrc_local,zshrc,zshrc setfiletype sh
]])

vim.cmd([[hi IlluminatedWordText ctermfg=Cyan guifg=#FF7373 gui=bold]])
vim.cmd([[hi IlluminatedWordRead ctermfg=Cyan guifg=#FF7373 gui=bold]])
vim.cmd([[hi IlluminatedWordWrite ctermfg=Cyan guifg=#FF7373 gui=bold]])
