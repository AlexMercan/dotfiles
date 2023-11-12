return {
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                excluded_filetypes = { "harpoon" },
                mark_branch = false,
            }
        },
        keys = {
            {"tj",  "<cmd>lua require('harpoon.ui').nav_file(1)<CR>",desc = "Open harpoon file 1" },
            {"tk", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>",desc =  "Open harpoon file 2" },
            {"tl", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "Open harpoon file 3" },
            {"t;", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>",desc =  "Open harpoon file 4" },
            {"<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",desc =  "Open harpoon menu" },
            {"<leader>a","<cmd>lua require('harpoon.mark').add_file()<CR>",desc = "Add file harpoon" },
        },
        config = function(_,opts)
            require("harpoon").setup(opts)
        end,
    },
}
