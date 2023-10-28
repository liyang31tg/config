local status, masonlspconfig = pcall(require, "mason-lspconfig")
if not status then
	vim.notify("没有找到 mason-lspconfig")
	return
end

masonlspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"golangci_lint_ls",
		"html",
		"bashls",
		"jsonls",
		"tsserver",
		"yamlls",
        "volar",
		-- "vuels",
		"denols",
		"dockerls",
		"docker_compose_language_service",
	}, --,"volar"
})
