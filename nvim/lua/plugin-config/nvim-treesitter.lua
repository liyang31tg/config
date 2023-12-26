local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("没有找到 nvim-treesitter")
  return
end

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "go" },
  -- ensure_installed = "all",
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    disable = { "lua" }, -- 不要加强lua高亮,因为keybind那个文件会卡出翔
    additional_vim_regex_highlighting = false, --关闭vim的正则高亮
  },
})
