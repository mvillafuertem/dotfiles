return {
  "folke/noice.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>nd",
      "<cmd>NoiceDismiss<cr>",
      desc = "Dismiss Noice Message"
    }
  },
  opts = {
    routes = {
      {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      },
    },
    presets = {
      lsp_doc_border = true,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
