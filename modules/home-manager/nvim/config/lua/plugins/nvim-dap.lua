return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	ft = { "scala", "sbt", "java" },
	config = function(_, _)
		-- Debug settings if you're using nvim-dap
		local dap = require("dap")
		local dapui = require("dapui")

		dap.configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "RunOrTest",
				metals = {
					runType = "runOrTestFile",
					--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
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
			{
				name = "Debug Attach (5005)",
				type = "scala",
				request = "attach",
				hostName = "localhost",
				port = 5005,
				buildTarget = "root",
			},
			{
				name = "Debug Attach Test (5005)",
				type = "scala",
				request = "attach",
				hostName = "localhost",
				port = 5005,
				buildTarget = "root-test",
			},
		}

		-- Setup DAPUI
		dapui.setup({
			icons = { collapsed = "", current_frame = "", expanded = "" },
			layouts = {
				{
					elements = { "scopes", "watches", "stacks", "breakpoints" },
					size = 80,
					position = "left",
				},
				{ elements = { "console", "repl" }, size = 0.25, position = "bottom" },
			},
			render = { indent = 2 },
		})

		-- Setup Virtual Text
		require("nvim-dap-virtual-text").setup({})

		-- Added event for open DAUI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
