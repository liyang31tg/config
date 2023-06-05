" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
echom "plug init"
call plug#begin('~/.local/share/nvim/plugged')
" inside plug#begin:
" use vscode easymotion when in vscode mode
"Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
call plug#end()
