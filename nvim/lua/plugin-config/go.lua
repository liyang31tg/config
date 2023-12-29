local status, go = pcall(require, "go")
if not status then
	vim.notify("没有找到 go")
	return
end

-- 只想用他的tag功能
go.setup({
	lsp_gofumpt = false,
	gopls_remote_auto = false,
	verbose_tests = false,
	tag_transform = "keep",
	tag_options = "",
	run_in_floaterm = true,
	dap_debug = false, --不用这一套
	dap_debug_keymap = false,
	lsp_keymaps = false,
	lsp_codelens = false,
	floaterm = { -- position
		posititon = "auto", -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
		width = 0.45, -- width of float window if not auto
		height = 0.98, -- height of float window if not auto
		title_colors = "nord", -- default to nord, one of {'nord', 'tokyo', 'dracula', 'rainbow', 'solarized ', 'monokai'}
		-- can also set to a list of colors to define colors to choose from
		-- e.g {'#D8DEE9', '#5E81AC', '#88C0D0', '#EBCB8B', '#A3BE8C', '#B48EAD'}
	},
})

require("keybindings").mapGo()
