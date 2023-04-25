"后面需要用这个判断条件
let mapleader=","
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
if exists('g:vscode')
    " VSCode extension
    source  $HOME/.config/nvim/init_vscode.vim
else
    " ordinary neovim
    source  $HOME/.config/nvim/init_nomal.vim
endif


source $HOME/.config/nvim/base_comm.vim

map <M-y> :write MM<cr>
map <A-y> :write AA<cr>
map <D-y> :write DD<cr>
