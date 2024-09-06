return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    -- :map <BS> :echo 'test command test map You pressed backspace!'<CR>
    {
      "<bs>",
      "<cmd>Oil<cr>",
      desc = "Open parent directiory",
    },
    {
      "<leader>-",
      "<cmd>Oil --float<cr>",
      desc = "Open parent directiory",
    }
  },
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
