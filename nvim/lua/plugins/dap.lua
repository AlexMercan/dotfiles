return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<F8>", "<cmd>lua require'dap'.step_over()<CR>", desc = "DAP step over" },
		{ "<F5>", "<cmd>lua require'dap'.continue()<CR>", desc = "DAP continue" },
		{ "<F7>", "<cmd>lua require'dap'.step_into()<CR>", desc = "DAP step into" },
		{ "<S-F8>", "<cmd>lua require'dap'.step_out()<CR>", desc = "DAP step out" },
		{ "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "DAP toggle breakpoint" },
	},
}
