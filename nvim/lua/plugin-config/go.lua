local status, go = pcall(require, "go")
if not status then
	vim.notify("没有找到 go")
	return
end

-- 只想用他的tag功能
go.setup({ 
	tag_transform = "keep",
	tag_options = "",
	run_in_floaterm = true,
	dap_debug = false, --不用这一套
	dap_debug_keymap = false,
    lsp_keymaps=false,
    lsp_codelens=false,
})

require("keybindings").mapGo()

