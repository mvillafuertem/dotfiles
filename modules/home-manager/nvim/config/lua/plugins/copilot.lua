return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			provider = "copilot",
			providers = {
				copilot = {
					model = "claude-sonnet-4.5",
				},
			},
			windows = {
				width = 40, -- default % based on available width in vertical layout
				height = 40, -- default % based on available height in horizontal layout
				input = {
					prefix = "> ",
					height = 20, -- Height of the input window in vertical layout
				},
				sidebar_header = {
					include_model = true,
				},
			},
		},
		build = "make", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		config = function(_, opts)
			require("avante").setup(opts)
			vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { bg = "#1e1e2e", fg = "#1e1e2e" })
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			-- "hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},

						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to setup it properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		-- config = function()
		--   require("avante").setup({
		--     -- system_prompt as function ensures LLM always has latest MCP server state
		--     -- This is evaluated for every message, even in existing chats
		--     system_prompt = function()
		--       local hub = require("mcphub").get_hub_instance()
		--       return hub and hub:get_active_servers_prompt() or ""
		--     end,
		--     -- Using function prevents requiring mcphub before it's loaded
		--     custom_tools = function()
		--       return {
		--         require("mcphub.extensions.avante").mcp_tool(),
		--       }
		--     end,
		--   })
		-- end,
	},
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"github/copilot.vim",
	-- 		-- The following are optional:
	-- 		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	-- 	},
	-- 	opts = {
	-- 		language = "Spanish", -- Default is "English",
	-- 		display = {
	-- 			chat = {
	-- 				render_headers = false,
	-- 			},
	-- 		},
	-- 		strategies = {
	-- 			chat = {
	-- 				adapter = "copilot",
	-- 				roles = { llm = "copilot", user = "mvillafuerte" },
	-- 			},
	-- 			inline = {
	-- 				adapter = "copilot",
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("codecompanion").setup(opts)
	-- 	end,
	-- },
	-- {
	--   "zbirenbaum/copilot.lua",
	--   cmd = "Copilot",
	--   event = "InsertEnter",
	--   dependencies = {
	--     "zbirenbaum/copilot-cmp",
	--   },
	--   config = function()
	--     require("copilot").setup({
	--       suggestion = { enabled = false },
	--       panel = { enabled = false },
	--     })
	--     require("copilot_cmp").setup()
	--   end,
	-- },
	-- {
	--   "ravitemer/mcphub.nvim",
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--   },
	--   build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
	--   config = function()
	--     require("mcphub").setup({
	--       use_bundled_binary = true, -- Use local `mcp-hub` binary
	--     })
	--   end,
	-- }
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "canary",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
	-- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	-- 	},
	-- 	build = "make tiktoken", -- Only on MacOS or Linux
	-- 	opts = {
	-- 		debug = true, -- Enable debugging
	-- 		-- See Configuration section for rest
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- },
}
