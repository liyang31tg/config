vim.cmd([[
  autocmd TermOpen term://* startinsert
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
