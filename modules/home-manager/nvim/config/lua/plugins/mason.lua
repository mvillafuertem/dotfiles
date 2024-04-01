return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  -- "WhoIsSethDaniel/mason-tool-installer.nvim",
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      automatic_installation = true
      -- ensure_installed = { "lua_ls", "rust_analyzer" }

      require("lspconfig").ast_grep.setup({})
      require("lspconfig").nil_ls.setup({})
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").rust_analyzer.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  { "neovim/nvim-lspconfig" },
}
