return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		-- {
		-- 	"rafamadriz/friendly-snippets",
		-- 	config = function()
		-- 		require("luasnip.loaders.from_vscode").lazy_load()
		-- 	end,
		-- },
	},
	config = function()
		local snip_status_ok, ls = pcall(require, "luasnip")
		if not snip_status_ok then
			return
		end

		local util_types_status_ok, types = pcall(require, "luasnip.util.types")
		if not util_types_status_ok then
			return
		end

		ls.log.set_loglevel("debug")

		ls.config.set_config({
			-- This tells LuaSnip to remember to keep around the last snippet.
			-- You can jump back into it even if you move outside of the selection
			history = true,
			-- This one is cool cause if you have dynamic snippets, it updates as you type!
			updateevents = "TextChanged,TextChangedI",
			-- Autosnippets:
			enable_autosnippets = true,
			-- ext_opts = nil,
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { " « ", "NonTest" } },
					},
				},
			},
			snip_env = {
				s = function(...)
					local snip = ls.s(...)
					-- we can't just access the global `ls_file_snippets`, since it will be
					-- resolved in the environment of the scope in which it was defined.
					table.insert(getfenv(2).ls_file_snippets, snip)
				end,
				parse = function(...)
					local snip = ls.parser.parse_snippet(...)
					table.insert(getfenv(2).ls_file_snippets, snip)
				end,
			},
		})

		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		vim.keymap.set("i", "<c-l>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end)

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/config/snippets" })
	end,
}
