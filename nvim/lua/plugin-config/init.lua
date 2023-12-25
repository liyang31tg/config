-- init.lua 加载这个模块的时候会自动执行
-- MARK 需要保证其再加顺序
-- local status0, _ = pcall(require, "plugin-config.mason")
-- if not status0 then
-- 	vim.notify("没有找到 plugin-config.mason")
-- 	return
-- end
--
-- local status1, _ = pcall(require, "plugin-config.mason-lspconfig")
-- if not status1 then
-- 	vim.notify("没有找到 plugin-config.mason-lspconfig")
-- 	return
-- end


local M = {}

local ends_with = require("utils").ends_with

-- 自动加载这个目录下的所有配置
M.setup = function()
	local config_dir = vim.fn.stdpath("config") .. "/lua/plugin-config"
	-- plugins do not need to load, NOTE: no .lua suffix required
	local unload_plugins = {
		"init", -- we don't need to load init again
		"mason",
		"mason-lspconfig",
	}

	local helper_set = {}
	for _, v in pairs(unload_plugins) do
		helper_set[v] = true
	end
	for _, fname in pairs(vim.fn.readdir(config_dir)) do
		if ends_with(fname, ".lua") then
			local cut_suffix_fname = fname:sub(1, #fname - #".lua")
			if helper_set[cut_suffix_fname] == nil then
				local file = "plugin-config." .. cut_suffix_fname
				local status_ok, _ = pcall(require, file)
				if not status_ok then
					vim.notify("Failed loading " .. fname, vim.log.levels.ERROR)
				end
			end
		end
	end
end

M.setup()
