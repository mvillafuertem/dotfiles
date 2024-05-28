return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  event = "VeryLazy",
  main = "nvim-treesitter.configs",
  opts = {
    -- auto_install = true,
    ensure_installed = {
      "bash",
      "dockerfile",
      "java",
      "json",
      "lua",
      "markdown",
      "nix",
      "rust",
      "scala",
      "hcl",
      "terraform",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      "gotmpl",
    },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
        },
      },
    },
  },
  -- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
  -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
  keys = {
    {
      ";",
      function()
        require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_next()
      end,
      mode = { "n", "x", "o" },
      -- silent = true,
      noremap = true,
      desc = "Treesitter Repeat Last Move Next",
    },
    {
      ",",
      function()
        require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_previous()
      end,
      mode = { "n", "x", "o" },
      -- silent = true,
      noremap = true,
      desc = "Treesitter Repeat Last Move Previous",
    },
  },
}
