local packer = require("packer")
packer.startup({
	function(use)
		use("lewis6991/impatient.nvim") --加强lua模块加载,就是加了个缓存序列化
		-- Packer 可以管理自己本身
		use("wbthomason/packer.nvim")

		use("rcarriga/nvim-notify") -- notify

		--侧栏目录结构
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
		use("simrat39/symbols-outline.nvim") --目录大纲
		--tab自定义的那个标签页,本质就是buffer，只是之前无地方显示提现
		use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
		--lualine
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		use("arkav/lualine-lsp-progress")

		-- telescope,各种检索
		use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

		-- project
		use("ahmedkhalf/project.nvim")

		--高亮
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		--textobj
		use("nvim-treesitter/nvim-treesitter-textobjects")

		-- 补全引擎
		use("hrsh7th/nvim-cmp")
		-- snippet 引擎
		use("hrsh7th/vim-vsnip") --用到上面的lsp提示
		-- 补全源
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
		use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
		use("hrsh7th/cmp-path") -- { name = 'path' }
		use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
		--------------------- LSP 也是注入到上面的补全源中才可以使用--------------------
		use({
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		})

		use("RRethy/vim-illuminate") -- 高亮sameid

		-- 常见编程语言代码段
		use("rafamadriz/friendly-snippets")

		-- linter and formatter
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

		--golang 强化,添加lsp以外的另外独特功能
		use({
			"ray-x/go.nvim",
			requires = {
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
		})

		-- 调试
		-- use("ravenxrz/DAPInstall.nvim") --DI 用于安装各种语言的debugger,mason有安装debugger相关,所以不再需要这个
		use("mfussenegger/nvim-dap")
		use("theHamsta/nvim-dap-virtual-text") --显示调试旁边的虚拟字体
		use("rcarriga/nvim-dap-ui")

		--类似于之前的vim-surround + 注释
		use({ "echasnovski/mini.nvim", branch = "stable" })

		--美化ui
		use("stevearc/dressing.nvim")

		--欢迎页面
		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("alpha").setup(require("alpha.themes.theta").config)
			end,
		})

		--测试模块
		use({
			"nvim-neotest/neotest",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-go", --可以添加其他的测试适配器，这个是go的
			},
		})

		use({
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		})
		--copilot
		-- use({ "zbirenbaum/copilot.lua" })

		--markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})

		-- colorschema start
		use("shaunsingh/nord.nvim")
		use("folke/tokyonight.nvim")
		use({
			"glepnir/zephyr-nvim",
			requires = { "nvim-treesitter/nvim-treesitter", opt = true },
		})
		-- colorschema end
		-- codeium
		use({
			"Exafunction/codeium.vim",
			config = function()
				-- Change '<C-g>' here to any keycode you like.
				vim.keymap.set("i", "<C-g>", function()
					return vim.fn["codeium#Accept"]()
				end, { expr = true })
				vim.keymap.set("i", "<c-;>", function()
					return vim.fn["codeium#CycleCompletions"](1)
				end, { expr = true })
				vim.keymap.set("i", "<c-,>", function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end, { expr = true })
				vim.keymap.set("i", "<c-x>", function()
					return vim.fn["codeium#Clear"]()
				end, { expr = true })
			end,
		})
		--自动保存代码,即使没保存的强制退出,也会保存
		-- use("Pocco81/auto-save.nvim")--与格式化那些有抖动效果
		use("akinsho/toggleterm.nvim") --nvim中的终端

		-- litee family 不好用,扯淡的
		-- use({
		-- 	"ldelossa/litee.nvim",
		-- 	commit = "47235cb807a83af866e06ce654b28efcfe347c60",
		-- })
		-- use({
		-- 	"ldelossa/litee-calltree.nvim",
		-- 	commit = "3f3c25e584558949b1eda38ded76eade28fa5fd6",
		-- })

		use("lewis6991/gitsigns.nvim")
		use("sindrets/diffview.nvim")
		use("folke/which-key.nvim") --下面的那个key的提示
		use("nvim-pack/nvim-spectre") --搜索替换
		use("folke/todo-comments.nvim") --NOTE  无法找到所有的TODO不知道什么问题
		use("ray-x/lsp_signature.nvim") -- 代码提示,每一个形参都会有提示
		use("fladson/vim-kitty") --高亮kitty配置
		use("mg979/vim-visual-multi") --多光标操作
		use({ "kosayoda/nvim-lightbulb" }) --点亮有code action的地方
        use("folke/zen-mode.nvim") --zenmode
        -- use("sindrets/winshift.nvim") --resize move win
        use("simeji/winresizer") -- resize move win
        use("rhysd/accelerated-jk") --加速jk的滚动,丝滑
        --todo plugin
        --flash.nvim
	end,
	config = {
		-- 并发数限制
		max_jobr = 16,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		-- 自定义源
		git = {
			-- default_url_format = "https://hub.fastgit.xyz/%s",
			-- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
			-- default_url_format = "https://gitcode.net/mirrors/%s",
			-- default_url_format = "https://gitclone.com/github.com/%s",
		},
	},
})
