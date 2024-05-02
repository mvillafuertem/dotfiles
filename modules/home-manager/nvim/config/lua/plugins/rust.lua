return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      --	vim.g.rustaceanvim = {
      --		server = {
      --			on_attach = require("lspconfig").on_attach,
      --			capabilities = require("lspconfig").capabilities,
      --		},
      --	}
    end,
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },
}
