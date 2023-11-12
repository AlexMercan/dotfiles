return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"benfowler/telescope-luasnip.nvim",
		},
		keys = {
			{
				"<C-s>w",
				"<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
				desc = "Workspace symbols",
			},
			{
				"<C-s>d",
				"<cmd>lua require('telescope.builtin').lsp_dynamic_document_symbols()<cr>",
				desc = "Document symbols",
			},
			{
				"<C-p>",
				"<cmd>lua require'telescope.builtin'.find_files()<cr>",
				desc = "Find files",
			},
			{
				"<C-g>",
				"<cmd>lua require('telescope.builtin').git_files()<cr>",
				desc = "Git files",
			},
			{
				"<C-f>",
				"<cmd>lua require('telescope.builtin').live_grep()<cr>",
				desc = "Live grep",
			},
            {
                "<C-s>s",
                "<cmd>lua require'telescope'.extensions.luasnip.luasnip{}<cr>",
                desc = "Luasnip snippets"
            }
		},
		lazy = true,
		opts = {
			defaults = {
				-- Default configuration for telescope goes here:
				-- config_key = value,
				file_ignore_patterns = {
					"mod/",
					".idea/",
					"%.class",
					".git/.*",
					"/usr/.*",
					"bin/.*",
					"node_modules/.*",
					"%.jar",
					"%.bin",
					"%.fxml",
					"%.xml",
					"obj/",
				},
				vimgrep_arguments = {
					"rg",
					"--follow",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--no-ignore",
					"--trim",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				git_files = {
					hidden = true,
				},
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("luasnip")
		end,
		--config = get_config("telescope"),
	},
}
