"复制来源https://github.com/theniceboy/vimrc-example/blob/master/vimrc
"作者 https://www.bilibili.com/video/BV1e4411V7AA?spm_id_from=333.1007.top_right_bar_window_history.content.click
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
let &t_ut=''
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set laststatus=2
" set ts=4 "设置tab为4个空格
" set expandtab "将tab展开为空格
nnoremap <leader>rc :e $HOME/.config/nvim/init.vim<cr>
nnoremap <leader>so :source $MYVIMRC<cr>  
augroup NVIMRC
    autocmd!
    autocmd BufWritePost *.nvimrc exec ":so %"
augroup END
"折叠代码za
" za "折叠代码
"无法转成lua，有bug
noremap \s :<c-u>%s//g<left><left>
"<c-数字> vim9.0已经支持，nvim自然也支持测试了，保证不是通过meta桥接
"<c-m-字母> 在nvim可使用 <ctrl+option+>
" Better Navigation
" Meta 桥接
" ,这类事件需要在iterm快捷键里映射下,<c-数字>vim不支持 ,<c-数字> nvim支持
" <D->
" 以下是对应的不支持映射的桥接关系大幅阿斯蒂芬
" <c-0> <M-f> 删除，因为已经支持映射<c-数字
" <cmd-s> <M-s>
" noremap <silent> <M-s> :w<cr>
" 被zellij占用<m-s>,用于显示会话信息了
"noremap <M-9> <esc>:<c-u>w<cr>
autocmd FileType cs nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term dotnet run % <CR>a
autocmd FileType typescript nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term deno run % <CR>a
noremap \p :echo expand('%:p')<CR>

hi IlluminatedWordText ctermfg=Cyan guifg=#FF7373 gui=bold
hi IlluminatedWordRead ctermfg=Cyan guifg=#FF7373 gui=bold
hi IlluminatedWordWrite ctermfg=Cyan guifg=#FF7373 gui=bold





