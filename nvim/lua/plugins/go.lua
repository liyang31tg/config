-- local opt = {
-- 	lsp_gofumpt = false,
-- 	gopls_remote_auto = false,
-- 	verbose_tests = false,
-- 	tag_transform = "keep",
-- 	tag_options = "",
-- 	run_in_floaterm = true,
-- 	dap_debug = false, --不用这一套
-- 	dap_debug_keymap = false,
-- 	lsp_keymaps = false,
-- 	lsp_codelens = false,
-- 	floaterm = { -- position
-- 		posititon = "auto", -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
-- 		width = 0.45, -- width of float window if not auto
-- 		height = 0.98, -- height of float window if not auto
-- 		title_colors = "nord", -- default to nord, one of {'nord', 'tokyo', 'dracula', 'rainbow', 'solarized ', 'monokai'}
-- 		-- can also set to a list of colors to define colors to choose from
-- 		-- e.g {'#D8DEE9', '#5E81AC', '#88C0D0', '#EBCB8B', '#A3BE8C', '#B48EAD'}
-- 	},
-- }
--
-- local obj = {
-- 	"ray-x/go.nvim",
-- 	dependencies = { -- optional packages
-- 		"ray-x/guihua.lua",
-- 		"neovim/nvim-lspconfig",
-- 		"nvim-treesitter/nvim-treesitter",
-- 	},
-- 	config = function()
-- 		require("go").setup(opt)
-- 		require("keybindings").mapGo()
-- 	end,
-- 	event = { "CmdlineEnter" },
-- 	ft = { "go", "gomod" },
-- 	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
-- }
--
-- return obj
--
--
local opt = {
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "impl",
		iferr = "iferr",
		dlv = "dlv",
	},
	gotests = {
		-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
		template = "default",
		-- path to a directory containing custom test code templates
		template_dir = nil,
		-- switch table tests from using slice to map (with test name for the key)
		-- works only with gotests installed from develop branch
		named = false,
	},
	gotag = {
		transform = "keep",
	},
}
local obj = {
	"olexsmir/gopher.nvim",
	ft = "go",
	-- branch = "develop", -- if you want develop branch
	-- keep in mind, it might break everything
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
	},
	-- (optional) will update plugin's deps on every update
	build = function()
		vim.cmd.GoInstallDeps()
	end,
	config = function()
		require("keybindings").mapGo()
	end,
	opts = opt,
}

return obj
