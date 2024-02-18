local servers = {
  lua_ls = {
    			settings = {
				Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
  },
  gopls = {},
  clangd = {
    cmd = {
				"clangd",
				"--header-insertion=never",
				"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
				"--all-scopes-completion",
				"--completion-style=detailed",
			},
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root_dir = require("lspconfig").util.root_pattern(
				"CMakeLists.txt",
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
				".git"
			),
			single_file_support = true,

  }


}

local obj = {
  "neovim/nvim-lspconfig",
  dependencies={
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config=function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
    })
    for server,config in pairs(servers) do
      require("lspconfig")[server].setup(
      vim.tbl_deep_extend("keep",{},config)
      )
    end
  end
}

return obj
