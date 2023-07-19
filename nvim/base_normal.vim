"复制来源https://github.com/theniceboy/vimrc-example/blob/master/vimrc
"作者 https://www.bilibili.com/video/BV1e4411V7AA?spm_id_from=333.1007.top_right_bar_window_history.content.click
"start 
syntax on
set number
set norelativenumber
set cursorline
set wrap
set showcmd
set wildmenu

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase


set nocompatible "不要兼容vi，兼容的话，本身很多命令用不了
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=''
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"set list
"set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
"set autochdir
"下面这个命令是想文件再次打开的时候保证cursor在原来的未知
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"end

set encoding=UTF-8
set nu rnu
set ts=4
set expandtab
set autoindent
set cursorline
set clipboard+=unnamedplus "支持系统粘贴板

"nnoremap <silent> Q :q<CR>
"nnoremap <silent> S :w<CR>
nnoremap <leader>rc :e $HOME/.config/nvim/init.vim<cr>
nnoremap <leader>so :source $MYVIMRC<cr>  "没用
augroup NVIMRC
    autocmd!
    autocmd BufWritePost *.nvimrc exec ":so %"
augroup END
" Ctrl + U or E will move up/down the view port without moving the cursor
noremap <C-j> 5<C-y>
noremap <C-k> 5<C-e>
" Folding
noremap <silent> <leader>o za "折叠代码
"快速插入没{}
inoremap <c-y> <ESC>A {}<ESC>i<CR><ESC>ko




"move cursor in window
"nnoremap <leader>w <c-w>w
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"move  window
nnoremap <C-A-H> <c-w>H
nnoremap <C-A-L> <c-w>L
nnoremap <C-A-J> <c-w>J
nnoremap <C-A-K> <c-w>K
"split
"nnoremap sl :set splitright<cr>:vsplit<cr>
"nnoremap sh :set nosplitright<cr>:vsplit<cr>:set splitright<cr>
"nnoremap sj :set splitbelow<cr>:split<cr>
"nnoremap sk :set nosplitbelow<cr>:split<cr>:set splitbelow<cr>
" Place the two screens up and down
noremap sn <C-w>t<C-w>K
" Place the two screens side by side
"noremap sv <C-w>t<C-w>H
" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H


"本来是水平分屏的改成垂直分屏
map scv <c-w>t<c-w>H
"本来是垂直分屏的改成水平分屏
map sch <c-w>t<c-w>K

"Disable the default key
noremap s <nop>
" Press ` to change case (instead of ~)
noremap ` ~
noremap \s :<c-u>%s//g<left><left>


"resize
"map <up> :res +5<cr>
"map <down> :res -5<cr>
"map <left> :vertical resize-5<cr>
"map <right> :vertical resize+5<cr>

"tab
":tabe 新建一个空白标签，暂时不需要
noremap tn :tab split<cr>
noremap tl :+tabnext<cr>
noremap th :-tabnext<cr>
noremap tml :+tabmove<CR>
noremap tmh :-tabmove<CR>

"term
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <esc> <C-\><C-n>
tnoremap <leader>q <C-\><C-n>:q<cr>
nnoremap <c-t> :set splitbelow<cr>:split<cr>:term<cr>
inoremap <c-t> <esc>:term<cr>
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l


nnoremap <silent><nowait> <leader>d :CocList diagnostics<cr>
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>= <Plug>(coc-diagnostic-next)


" Text Objects 
" iw,aw,这些都是TextObject
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
" x 是试图模式
" o 是操作准备模式, 前置需要一个操作命令（operator）
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
xmap ac <Plug>(coc-classobj-a)



" GoTo code navigation
nmap fy <Plug>(coc-translator-p)


set cursorline
syntax enable

"set background=dark
"windows
nnoremap <leader>q  :q<cr>

"<c-数字> vim9.0已经支持，nvim自然也支持测试了，保证不是通过meta桥接
"<c-m-字母> 在nvim可使用 <ctrl+option+>
" Better Navigation
" Meta 桥接
" ,这类事件需要在iterm快捷键里映射下,<c-数字>vim不支持 ,<c-数字> nvim支持
" <D->
" 以下是对应的不支持映射的桥接关系大幅阿斯蒂芬
" <c-0> <M-f> 删除，因为已经支持映射<c-数字
" <cmd-s> <M-s>
noremap <silent> <M-s> :w<cr>


hi comment ctermfg =darkyellow
" 设置行号颜色
highlight LineNr ctermfg=red 

autocmd FileType cs nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term dotnet run % <CR>a
autocmd FileType typescript nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term deno run % <CR>a


noremap \p :echo expand('%:p')<CR>






