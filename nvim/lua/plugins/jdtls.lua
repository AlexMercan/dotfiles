return {
	"neovim/nvim-lspconfig",
	dependencies = { "mfussenegger/nvim-jdtls" },
	opts = {
		setup = {
			jdtls = function()
				local JdtlsLspGroup = vim.api.nvim_create_augroup("JdtlsLsp", { clear = false })
				vim.api.nvim_create_autocmd("Filetype", {
					group = JdtlsLspGroup,
					pattern = "java",
					callback = function()
						local opts = { silent = true, noremap = true }
						local keymap = vim.api.nvim_set_keymap
						local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
						local home = os.getenv("HOME")
						local workspace_dir = home .. "/jdtls_workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
						local config = {
							-- The command that starts the language server
							-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
							cmd = {

								-- 💀
								"java", -- or '/path/to/java17_or_newer/bin/java'
								-- depends on if `java` is in your $PATH env variable and if it points to the right version.

								"-Declipse.application=org.eclipse.jdt.ls.core.id1",
								"-Dosgi.bundles.defaultStartLevel=4",
								"-Declipse.product=org.eclipse.jdt.ls.core.product",
								"-Dlog.protocol=true",
								"-Dlog.level=ALL",
								"-Xms1g",
								"--add-modules=ALL-SYSTEM",
								"--add-opens",
								"java.base/java.util=ALL-UNNAMED",
								"--add-opens",
								"java.base/java.lang=ALL-UNNAMED",
								"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",

								-- 💀
								"-jar",
								home
									.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
								-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

								-- Must point to the                                                     Change this to

								-- eclipse.jdt.ls installation                                           the actual version

								-- 💀
								"-configuration",
								home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
								-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
								-- Must point to the                      Change to one of `linux`, `win` or `mac`
								-- eclipse.jdt.ls installation            Depending on your system.

								-- 💀
								-- See `data directory configuration` section in the README
								"-data",
								workspace_dir,
							},
							-- 💀
							-- This is the default if not provided, you can remove it. Or adjust as needed.
							-- One dedicated LSP server & client will be started per unique root_dir
							root_dir = root_dir,
							-- Here you can configure eclipse.jdt.ls specific settings
							-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
							-- for a list of options
							settings = {
								java = {
									signatureHelp = { enabled = true },
									eclipse = { downloadSources = true },
									maven = { downloadSources = true, updateSnapshots = true },
									format = {
										settings = {
											url = "~/.config/nvim/config/style/java/modified-google.xml",
											profile = "GoogleStyle",
										},
									},
								},
							},
						}
						local on_attach = function(client, bufnr)
							require("jdtls.setup").add_commands()
							require("jdtls").setup_dap({})
							require("jdtls.dap").setup_dap_main_class_configs()
						end
						config.on_attach = on_attach

						local jar_patterns = {
							"/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
							"/.local/share/nvim/mason/packages/java-test/extension/server/*.jar",
						}

						local bundles = {}
						for _, jar_pattern in ipairs(jar_patterns) do
							for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
								if not vim.endswith(bundle, "com.microsoft.java.test.runner.jar") then
									table.insert(bundles, bundle)
								end
							end
						end
						config.init_options = { bundles = bundles }

						vim.cmd([[
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()
    ]])

						keymap("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
						keymap("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
						keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
						keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
						keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
						keymap("x", "crm", "<Cmd>lua require('jdtls').extract_method()<CR>", opts)
						keymap("n", "<leader>tc", "<Cmd>lua require('jdtls').test_class()<CR>", opts)
						keymap("n", "<leader>tm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", opts)

						-- This starts a new client & server,
						-- or attaches to an existing client & server depending on the `root_dir`.
						--
						require("jdtls").start_or_attach(config)
					end,
				})
				return true
			end,
		},
	},
}
