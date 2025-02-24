return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      -- extensions = { "quickfix" },
      options = {
        theme = "catppuccin",
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            mode = 0,
            icons_enabled = true,
            show_filename_only = true,
            hide_filename_extensions = false,
            separator = "|",
          },
        },
        lualine_z = {
          { "tabs", max_length = vim.o.columns },
        },
      },
      --			sections = {
      --				lualine_a = {
      --					"mode",
      --					{
      --						require("noice").api.statusline.mode.get,
      --						cond = require("noice").api.statusline.mode.has,
      --						-- color = { fg = "#ff9e64" },
      --					},
      --				},
      --			},
      inactive_winbar = {
        -- lualine_c = { "filename" },
        -- lualine_y = { { "filetype", icon_only = true } },
        -- lualine_z = { { "filename", path = 1 } },
      },
    })
  end,
}
