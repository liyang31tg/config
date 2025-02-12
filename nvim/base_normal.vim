
"复制来源https://github.com/theniceboy/vimrc-example/blob/master/vimrc
"作者 https://www.bilibili.com/video/BV1e4411V7AA?spm_id_from=333.1007.top_right_bar_window_history.content.click
" filetype plugin indent on
let &t_ut='' "vim.opt.t_ut设置报错,就再这里设置吧,不知道干啥用
" set tw=0
" set indentexpr=
" set foldmethod=indent
" set foldlevel=99
" set laststatus=2
" set ts=4 "设置tab为4个空格
" set expandtab "将tab展开为空格
nnoremap <leader>rc :e $HOME/.config/nvim/init.vim<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
augroup NVIMRC
    autocmd!
    autocmd BufWritePost *.nvimrc exec ":so %"
augroup END

"无法转成lua，有bug
noremap \s :<c-u>%s//g<left><left>

noremap \p :echo expand('%:pp')<CR>


augroup csharp_terminal
    autocmd!
    autocmd FileType cs nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term dotnet run % <CR>a
augroup END

augroup typescript_terminal
    autocmd!
    autocmd FileType typescript nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term deno run % <CR>a
augroup END

augroup python_terminal
    autocmd!
    autocmd FileType python nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term python3 % <cr>a
    autocmd FileType python nnoremap <localleader>r :set splitbelow<cr> :sp <CR> :term python3 % <cr>a
augroup END


augroup tmplFileTypeDetect
    autocmd!
    autocmd BufNewFile,BufRead *.tmpl set filetype=html
augroup END



