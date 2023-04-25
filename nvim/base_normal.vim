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
"exec "set nu rnu"
set ts=4
set expandtab
set autoindent
set cursorline
set clipboard+=unnamedplus "支持系统粘贴板

" highlght 主要是用来配色的，包括语法高亮等个性化的配置。可以通过:h highlight，查看详细信息

"CursorLine 和 CursorColumn 分别表示当前所在的行列

"cterm 表示为原生vim设置样式，设置为NONE表示可以自定义设置。

"ctermbg 设置终端vim的背景色

"ctermfg 设置终端vim的前景色

"guibg 和 guifg 分别是设置gvim的背景色和前景色，本人平时都是使用终端打开vim，所以只是设置终端下的样式

"set cursorline  "高亮显示当前行
"autocmd WinEnter * highlight CursorLine guibg=#000050 guifg=fg
"autocmd WinLeave * highlight CursorLine guibg=#004000 guifg=fg
"set cursorcolumn  "高亮显示当前列
"autocmd BufEnter * highlight CursorColumn ctermfg=fg ctermbg=fg cterm=bold guifg=#FF0000 guibg=#EE82EE gui=bold
"autocmd BufLeave * highlight CursorColumn ctermfg=NONE  ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
"au FileType fzf nnoremap <buffer> <esc> :q<cr>
"move cursor in window
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
"move  window
nnoremap <leader>h <c-w>H
nnoremap <leader>l <c-w>L
nnoremap <leader>j <c-w>J
nnoremap <leader>k <c-w>K
"split
nnoremap sl :set splitright<cr>:vsplit<cr>
nnoremap sj :set splitbelow<cr>:split<cr>
nnoremap sk :set nosplitbelow<cr>:split<cr>
nnoremap sh :set nosplitright<cr>:vsplit<cr>

"本来是水平分屏的改成垂直分屏
map scv <c-w>t<c-w>H
"本来是垂直分屏的改成水平分屏
map sch <c-w>t<c-w>K
"resize
map <up> :res +5<cr>
map <down> :res -5<cr>
map <left> :vertical resize-5<cr>
map <right> :vertical resize+5<cr>
"tab
map tn :tabe<cr>
map tl :+tabnext<cr>
map th :-tabnext<cr>

"placeholder
map <space><space> <esc>/<cr>:nohlsearch<cr>c4l
nnoremap <c-t> :term<cr>a
nnoremap <c-f> :Ag 
inoremap <c-f> <esc>:Ag 

nnoremap <c-p> :Files<cr>
"inoremap <c-p> <esc>:Files<cr> "选择输入的时候，提示ctrl+n ctrl+p 冲突

nnoremap <c-b> :Buffers<cr>
inoremap <c-b> <esc>:Buffers<cr>

"nmap <silent> f :Format<cr>
set background=light

"colorscheme nord
"colorscheme gruvbox-material
"colorscheme vim-material
"colorscheme onedark
"colorscheme snazzy
"colorscheme rose-pine
"colorscheme lightline
"colorscheme solarized
"colorscheme solarized8
set t_Co=256
set cursorline
colorscheme onehalflight
let g:airline_theme='onehalfdark'
" ==================== Terminal Colors ====================

"set background=dark
"windows
nnoremap <leader>q  :q<cr>
nnoremap <c-d>  :q<cr>
inoremap <c-d>  <esc>:q<cr>

" Better Navigation
" Meta 桥接
" ,这类事件需要在iterm快捷键里映射下,<c-数字>vim不支持
" 以下是对应的不支持映射的桥接关系大幅阿斯蒂芬
" <c-0> <M-f>
" <cmd-s> <M-s>
map <M-f> :NERDTreeFocus<cr>
noremap <F2> :NERDTreeFind<cr>
map <M-s> :w<cr>
map <D-s> :w<cr>
inoremap <D-s> <esc>:w<cr>a
map <A-s> :w<cr>


hi comment ctermfg =darkyellow
" 设置行号颜色
highlight LineNr ctermfg=red 

autocmd FileType cs nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term dotnet run % <CR>a
autocmd FileType typescript nnoremap <leader>r :set splitbelow<cr> :sp <CR> :term deno run % <CR>a
