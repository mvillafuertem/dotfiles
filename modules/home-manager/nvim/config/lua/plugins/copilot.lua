return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "copilot",
    },
    build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",    -- for providers='copilot'
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
      config = function()
        require("avante").setup({
          provider = "copilot",
        })
      end,
      {
        -- Make sure to setup it properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
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
  -- 	"zbirenbaum/copilot.lua",
  -- 	cmd = "Copilot",
  -- 	event = "InsertEnter",
  -- 	dependencies = {
  -- 		"zbirenbaum/copilot-cmp",
  -- 	},
  -- 	config = function()
  -- 		require("copilot").setup({
  -- 			suggestion = { enabled = false },
  -- 			panel = { enabled = false },
  -- 		})
  -- 		require("copilot_cmp").setup()
  -- 	end,
  -- },
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
