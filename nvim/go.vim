" neocomplete like '来源:https://github.com/deoplete-plugins/deoplete-go
"set completeopt+=noinsert
"set completeopt+=noselect
"因为t有直到的意思，用于跳转
" au FileType go nmap <leader>tb :GoAddTags bson<cr>
" au FileType go nmap <leader>tj :GoAddTags json<cr>
" au FileType go nmap <leader>tt :GoAddTags toml<cr>
" au FileType go nmap <leader>ty :GoAddTags yaml<cr>
" au FileType go nmap <leader>tx :GoAddTags xml<cr>
" au FileType go nmap <leader>tc :GoRemoveTags <cr>

" au FileType go nnoremap <leader>r <Plug>(go-run)
" au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>tt <Plug>(go-test)
" au FileType go nmap <Leader>tf <Plug>(go-test-func)
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nnoremap <leader>gt :normal vaf<cr>:GoUnit<cr>


let g:go_def_mapping_enabled = 0
let g:go_def_mode="gopls"
let g:go_info_mode='gopls'
let g:go_fmt_command = 'gopls'
let g:go_addtags_transform = 'keep'
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_fields = 0
let g:go_highlight_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 0
let g:go_auto_type_info = 0
let g:go_mod_fmt_autosave = 0
let g:go_asmfmt_autosave = 0
let g:go_metalinter_autosave = 0

let g:go_highlight_generate_tags = 0
let g:go_highlight_function_arguments = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_format_strings = 0
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0 

"从文档中获得，用于关闭所有功能,只开启sameids
let g:go_version_warning = 0
let g:go_code_completion_enabled = 0
let g:go_play_open_browser = 0
let g:go_gopls_enabled = 1
let g:go_auto_sameids = 1
let g:go_updatetime = 200
let g:go_jump_to_error = 0
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_search_bin_path_first = 0
let g:go_get_update = 0
let g:go_textobj_enabled = 0
let g:go_textobj_include_function_doc = 0
let g:go_textobj_include_variable = 0
let g:go_list_autoclose = 0
let g:go_term_close_on_exit = 0
let g:go_template_autocreate = 0
let g:go_echo_command_info = 0
let g:go_echo_go_info = 0
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 0









