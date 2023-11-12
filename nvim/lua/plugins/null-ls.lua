return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local nls = require("null-ls")
        local opts = {
            sources = {
                nls.builtins.formatting.goimports,
                nls.builtins.formatting.gofumpt,
                nls.builtins.formatting.stylua,
                nls.builtins.formatting.shellharden,
                nls.builtins.diagnostics.eslint,
                nls.builtins.diagnostics.golangci_lint,
                nls.builtins.diagnostics.buf,
                nls.builtins.formatting.buf,
                nls.builtins.formatting.prettier.with({
                    extra_args = { "--single-quote", "false" },
                }),
            },
        }
        nls.setup(opts)
    end,
}
