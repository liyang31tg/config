local status, masonlspconfig = pcall(require, "mason-lspconfig")
if not status then
    vim.notify("没有找到 mason-lspconfig")
    return
end

masonlspconfig.setup({
      ensure_installed = { "lua_ls","gopls","golangci_lint_ls","html" },
})

