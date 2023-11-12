return  {
    "windwp/nvim-autopairs",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    opts = {
        disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt", "vim" },
        })

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end
        --config = get_config("autopairs"),
}
