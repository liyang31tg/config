" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
" Initialize plugin system
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter' "注释用的插件
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot' "语法高亮的一个补充和onedark主题结合
"Plug 'fatih/vim-go', {'tag':'v1.27', 'do': ':GoUpdateBinaries' }
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }
Plug 'hexdigest/gounit-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "go lsp 最重要的就是enable：false，这个是修复重复提示那个bug的，我也不知道为啥
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
"Plug 'junegunn/fzf.vim'
Plug 'liyang31tg/vim-snippets'
Plug 'mhinz/vim-startify'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
Plug 'OmniSharp/omnisharp-vim' "csharp 专用
"Plug 'dense-analysis/ale' "csharp 专用
Plug 'majutsushi/tagbar'
"airline start
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'itchyny/lightline.vim' "主题
"airline end
" 配色方案start
" colorscheme neodark
"Plug 'KeitaNakamura/neodark.vim'
" colorscheme monokai
"Plug 'crusoexia/vim-monokai'
" colorscheme one 
"Plug 'rakr/vim-one'
"Plug 'https://github.com/joshdick/onedark.vim.git' "主题
"Plug 'nordtheme/vim' "主题
"Plug 'hzchirs/vim-material' "主题
"Plug 'catppuccin/nvim' "主题
"Plug 'connorholyday/vim-snazzy'
"Plug 'rose-pine/neovim' 
"Plug 'lifepillar/vim-solarized8'
"Plug 'sainnhe/gruvbox-material'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nightsense/snow'
Plug 'fladson/vim-kitty'
Plug 'https://github.com/rhysd/vim-clang-format.git'
"配色方案结束
call plug#end()


"nerdtree ====================================================== setting
" Start NERDTree and put the cursor back in the other window.
"au VimEnter * NERDTree 
" Exit Vim if NERDTree is the only window remaining in the only tab.
au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"let NERDTreeIgnore=['\~$','\.go1$',"^node_modules$","_test.go$"]
let NERDTreeIgnore=['\~$','\.go1$',"^node_modules$",'\.meta$','_test.go$','^_.*\.go$']
map <F3> :NERDTreeToggle<CR>
map <F2> :NERDTreeFind<CR>


let g:NERDCustomDelimiters = {
        \ 'go': { 'left': '//' }
    \ }



"lightline setting start ===================================
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction
"let g:airline_theme='supernova'
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
"lightline setting end ===================================



"one dark theme start ==========================
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"one dark theme end ==========================

"format proto

"let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_prog = "/usr/local/bin/python3"

"function! Formatonsave()
  "let l:formatdiff = 1
  "pyf ~/Documents/workspace/clang/tools/clang-format/clang-format.py
"endfunction
"autocmd BufWritePre *.h,*.cc,*.cpp,*.proto call Formatonsave()
"
"
"csharp      start =================
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_use_net6 = 1

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>f <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END
"csharp      end  ==================
"tagbar
nmap <F8> :TagbarToggle<CR>
"fzf
"export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'
"自定义fzf弹窗颜色，这个配置是全局设置在.zshrc里面，下面这个配置同上，下面这个配置是使用主题色
let g:fzf_colors =                                                                         
   \ { 'fg':      ['fg', 'Normal'],                                                           
   \ 'bg':      ['bg', 'Normal'],                                                           
   \ 'hl':      ['fg', 'Comment'],                                                          
   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
   \ 'hl+':     ['fg', 'Statement'],                                                        
   \ 'info':    ['fg', 'PreProc'],                                                          
   \ 'border':  ['fg', 'Ignore'],                                                           
   \ 'prompt':  ['fg', 'Conditional'],                                                      
   \ 'pointer': ['fg', 'Exception'],                                                        
   \ 'marker':  ['fg', 'Keyword'],                                                          
   \ 'spinner': ['fg', 'Label'],                                                            
   \ 'header':  ['fg', 'Comment'] }


  au FileType vue let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'vite.config.js', 'vue.config.js', 'nuxt.config.ts']


" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

let g:coc_node_path = '/usr/local/bin/node'


"#===========================fzf-preview start=============================
nmap <leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

nmap <c-p> [fzf-p]p
nmap <c-b> [fzf-p]B 
imap <c-b> <esc>[fzf-p]B 
map <c-f> [fzf-p]gr
"#===========================fzf-preview end================================================

"#===========================clang-format start=============================
"开启自动格式化
autocmd FileType c,proto ClangFormatAutoEnable
"#===========================clang-format end=============================
