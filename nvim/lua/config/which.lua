-- disable v
-- local presets = require("which-key.plugins.presets")
-- presets.operators["v"] = nil
require("which-key").setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 2, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = {
		"<silent>",
		"<cmd>",
		"<Cmd>",
		"<cr>",
		"<CR>",
		"call",
		"lua",
		"require",
		"^:",
		"^ ",
	}, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
})

local wk = require("which-key")
default_options = { silent = true }

wk.register({
	["<leader>"] = {
		name = "leader",
		rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
		e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open float" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set loclist" },
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "Format doc" },
		a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add file harpoon" },
		g = {
			n = { "<cmd>Neogit<cr>", "Open Neogit" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
		},
	},
	g = {
		name = "goto",
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>zz", "Go to definition" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" },
	},
	t = {
		name = "Harpoon",
		j = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Open harpoon file 1" },
		k = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Open harpoon file 2" },
		l = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Open harpoon file 3" },
		[";"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Open harpoon file 4" },
	},
	["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>zz", "Prev diagnostic" },
	["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>zz", "Next diagnostic" },
	["<C-b>"] = {
		name = "Symbols",
		w = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", "Workspace symbols" },
		d = { "<cmd>lua require('telescope.builtin').lsp_dynamic_document_symbols()<cr>", "Document symbols" },
	},
	["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
	["<C-p>"] = { "<cmd>lua require'telescope.builtin'.find_files()<cr>", "Find files" },
	["<C-f>"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep" },
	["<C-e>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Open harpoon menu" },
	["<C-t>"] = { "<cmd>NvimTreeToggle<cr>", "Toogle Tree" },
	["<C-q>"] = { "<cmd> lua require('config.functions').toggle_qf()<cr>", "Toggle qf list" },
}, { mode = "n", default_options })
