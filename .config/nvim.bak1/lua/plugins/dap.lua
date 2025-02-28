return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("nvim-dap-virtual-text").setup()
			require("dapui").setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.70 },
							{ id = "breakpoints", size = 0.10 },
							{ id = "stacks", size = 0.20 },
						},
						position = "left",
						size = 50,
					},
					{
						elements = { { id = "repl", size = 1 } },
						position = "bottom",
						size = 10,
					},
				},
			})

			-- Load Python-specific DAP configuration
			require("plugins.DAP.python").setup()
		end,
	},
}
