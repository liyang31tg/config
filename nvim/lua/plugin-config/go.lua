local status, go = pcall(require, "go")
if not status then
	vim.notify("没有找到 go")
	return
end

go.setup({
	tag_transform = "keep",
	tag_options = "",
	run_in_floaterm = true,
	dap_debug = false, --不用这一套
	dap_debug_keymap = false,
})

require("keybindings").mapGo()

--autosave
-- local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		require("go.format").goimport()
-- 	end,
-- 	group = format_sync_grp,
-- })
