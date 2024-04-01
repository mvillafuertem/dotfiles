return {
	"scalameta/nvim-metals",
	requires = {
		"nvim-lua/plenary.nvim",
		"j-hui/fidget.nvim",
		{
			"mfussenegger/nvim-dap",
			config = function(self, opts)
				local dap = require("dap")
				dap.configurations.scala = {
					{
						type = "scala",
						request = "launch",
						name = "RunOrTest",
						metals = {
							runType = "runOrTestFile",
						},
					},
					{
						type = "scala",
						request = "launch",
						name = "Test Target",
						metals = {
							runType = "testTarget",
						},
					},
				}
			end,
		},
	}

}
