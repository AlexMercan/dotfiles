require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "phpdoc" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
