-- 如果找不到lualine 组件，就不继续执行
local status, auto_save = pcall(require, "auto-save")
if not status then
    vim.notify("没有找到 auto-save")
  return
end

auto_save.setup()

