return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = "Telescope",
        opts = require("configs.telescope"),
    },
}
