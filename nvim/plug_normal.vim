" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
" Initialize plugin system
"Plug 'preservim/nerdtree'
"Plug 'preservim/nerdcommenter' "注释用的插件
"Plug 'ryanoasis/vim-devicons'
"Plug 'sheerun/vim-polyglot' "语法高亮的一个补充和onedark主题结合
"Plug 'fatih/vim-go', {'tag':'v1.27', 'do': ':GoUpdateBinaries' }
"Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }
"Plug 'hexdigest/gounit-vim'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'} "go lsp 最重要的就是enable：false，这个是修复重复提示那个bug的，我也不知道为啥
Plug 'jiangmiao/auto-pairs'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
"Plug 'junegunn/fzf.vim'
"Plug 'liyang31tg/vim-snippets'
"Plug 'mhinz/vim-startify'
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
"Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
"Plug 'OmniSharp/omnisharp-vim' "csharp 专用
"Plug 'dense-analysis/ale' "csharp 专用
"Plug 'majutsushi/tagbar'
"airline start
Plug 'fladson/vim-kitty'
Plug 'https://github.com/rhysd/vim-clang-format.git'
"配色方案结束
call plug#end()
let g:python3_host_prog = "/usr/local/bin/python3"
"#===========================clang-format start=============================
"开启自动格式化
autocmd FileType c,proto ClangFormatAutoEnable
"#===========================clang-format end=============================
