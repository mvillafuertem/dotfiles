return {
  "nvim-telescope/telescope.nvim",
  -- tag = "0.1.6",
  branch = "master",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status()
      end,
      desc = "Telescope Git Status",
    },
    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_bcommits()
      end,
      desc = "Telescope Git Buffer Commits",
    },
    {
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      desc = "undo history",
    }
    --		{
    --			"<leader>rp",
    --			function()
    --				require("telescope.builtin").find_files({
    --					prompt_title = "Plugins",
    --					cwd = "~/.config/nvim/lua/plugins/",
    --					attach_mappings = function(_, map)
    --						local actions = require("telescope.actions")
    --						local action_state = require("telescope.actions.state")
    --						map("i", "<C-y>", function(prompt_bufnr)
    --							local new_plugin = action_state.get_current_line()
    --							actions.close(prompt_bufnr)
    --							vim.cmd(string.format("edit ~/.config/nvim/lua/plugins/%s.lua", new_plugin))
    --						end)
    --						return true
    --					end,
    --				})
    --			end,
    --		},
  },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
    vim.keymap.set("n", "<leader>po", builtin.oldfiles, {})
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
    require("telescope").setup({
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = false,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "ivy",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })
    require("telescope").load_extension("fzf")
    -- require("telescope").load_extension("noice")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("undo")
  end,
}
