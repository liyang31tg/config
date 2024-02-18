local obj = {
  { --加强jk
    "rhysd/accelerated-jk",
    config=function()
      require("keybindings").accelerated()
    end,
  },
  { --保证文件打开的位置
    "ethanholz/nvim-lastplace",
    config=true,
  },
  { --只能跳转
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() jequire("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
},
  {
    "echasnovski/mini.surround",
    config=function()
      local opt = {
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		replace = "sr", -- Replace surrounding
		find = "sf", -- Find surrounding (to the right)
		find_left = "sF", -- Find surrounding (to the left)
		highlight = "sh", -- Highlight surrounding
		update_n_lines = "sn", -- Update `n_lines`
		suffix_last = "", -- Suffix to search with "prev" method
		suffix_next = "", -- Suffix to search with "next" method
	},
}
      require("mini.surround").setup(opt)
    end,
  },
  {
    "echasnovski/mini.comment",
    config=function()
      local opt = {
	mappings = {
		-- Toggle comment (like `gcip` - comment inner paragraph) for both
		-- Normal and Visual modes
		comment = ",c",
		-- Toggle comment on current line
		comment_line = ",cc",
		-- Toggle comment on visual selection
		comment_visual = ",c",
		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		textobject = ",c",
	},
}
      require("mini.comment").setup(opt)
    end

  },
  {
        "echasnovski/mini.pairs",
    config = function()
      local opt = {
	-- In which modes mappings from this `config` should be created
	modes = { insert = true, command = false, terminal = false },

	-- Global mappings. Each right hand side should be a pair information, a
	-- table with at least these fields (see more in |MiniPairs.map|):
	-- - <action> - one of 'open', 'close', 'closeopen'.
	-- - <pair> - two character string for pair to be used.
	-- By default pair is not inserted after `\`, quotes are not recognized by
	-- `<CR>`, `'` does not insert pair after a letter.
	-- Only parts of tables can be tweaked (others will use these defaults).
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
		["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
	},
}
      require("mini.pairs").setup(opt)
    end

  },
  {
        "echasnovski/mini.ai",
    config = function()
      local opt = {
	-- Table with textobject id as fields, textobject specification as values.
	-- Also use this to disable builtin textobjects. See |MiniAi.config|.
	custom_textobjects = nil,

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Main textobject prefixes
		around = "a",
		inside = "i",

		-- Next/last variants
		around_next = "an",
		inside_next = "in",
		around_last = "al",
		inside_last = "il",

		-- Move cursor to corresponding edge of `a` textobject
		goto_left = "g[",
		goto_right = "g]",
	},

	-- Number of lines within which textobject is searched
	n_lines = 50,

	-- How to search for object (first inside current line, then inside
	-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
	-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
	search_method = "cover_or_next",

	-- Whether to disable showing non-error feedback
	silent = false,
}
      require("mini.ai").setup(opt)
    end
  },
  {
    "rcarriga/nvim-notify",
    config=true,
  },
{
  "folke/zen-mode.nvim",
    config=true,
},
  {
    "fladson/vim-kitty",
    config=function()
    end,
  }

}

return obj
