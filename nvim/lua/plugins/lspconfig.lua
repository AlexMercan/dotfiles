return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"RRethy/vim-illuminate",
		{
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						cmd = { "lua-language-server" },
						filetypes = { "lua" },
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						completion = { enable = true, callSnippet = "Both" },
						diagnostics = {
							enable = true,
							globals = { "vim", "describe" },
							disable = { "lowercase-global" },
						},
						workspace = {
							library = {
								vim.api.nvim_get_runtime_file("", true),
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.expand("/usr/share/awesome/lib")] = true,
							},
							-- adjust these two values if your performance is not optimal
							maxPreload = 2000,
							preloadFileSize = 1000,
						},
						telemetry = { enable = false },
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							kubernetes = "k8s-*.yaml",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
						},
					},
				},
			},
			bashls = {},
			jsonls = {},
			ts_ls = {},
			gopls = {},
			dockerls = {},
			solidity = {},
			angularls = {},
			buf_ls = {},
			jdtls = {},
		},
		-- Global capabilities
		capabilities = {},
		setup = {},
	},
	config = function(_, opts)
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		local servers = opts.servers
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities(),
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		for server, _ in pairs(servers) do
			setup(server)
		end
	end,
}
