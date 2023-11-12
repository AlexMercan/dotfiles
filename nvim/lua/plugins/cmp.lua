return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "L3MON4D3/LuaSnip" },
        },
        event = "InsertEnter",
        opts = function()
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if not cmp_status_ok then
                print("Failed to load cmp")
                return
            end

            local snip_status_ok, luasnip = pcall(require, "luasnip")
            if not snip_status_ok then
                print("Failed to load luasnip")
                return
            end

            return {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-i>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = "nvim_lsp", max_item_count = 14 },
                    { name = "luasnip",  max_item_count = 2 },
                    { name = "buffer",   max_item_count = 2 },
                    { name = "path" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                test_config = {
                    name = "Harpoon",
                    j = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Open harpoon file 1" },
                    k = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Open harpoon file 2" },
                    l = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Open harpoon file 3" },
                    [";"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Open harpoon file 4" },
                },
                experimental = {
                    ghost_text = false,
                    native_menu = false,
                },
            }
        end
        --config = get_config("cmp"),
    },
}
