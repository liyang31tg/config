local packer = require("packer")
packer.startup({
	function(use)
		-- Packer 可以管理自己本身
		use("wbthomason/packer.nvim")
		--主题
		use("folke/tokyonight.nvim")
		--侧栏目录结构
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
        --tab自定义的那个标签页,本质就是buffer，只是之前无地方显示提现
		use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
		--lualine
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		use("arkav/lualine-lsp-progress")
		-- telescope，类似于fzf
		use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

		-- project
		use("ahmedkhalf/project.nvim")

		--高亮
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		--textobj
		use("nvim-treesitter/nvim-treesitter-textobjects")

		--------------------- LSP --------------------
		use({
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		})

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

		-- 常见编程语言代码段
		use("rafamadriz/friendly-snippets")

		-- 代码格式化
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

		-- 调试
		use("mfussenegger/nvim-dap")
		use("theHamsta/nvim-dap-virtual-text")
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

	end,
	config = {
		-- 并发数限制
		max_jobs = 16,
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
