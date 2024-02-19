local obj = {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("spectre").setup()
    end,
}

return obj
