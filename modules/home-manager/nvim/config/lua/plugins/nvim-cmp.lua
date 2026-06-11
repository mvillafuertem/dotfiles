return {
  "hrsh7th/nvim-cmp",
  -- event = "VeryLazy",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-git",
    --
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "crates" },
        { name = "avante_commands" },
        { name = "avante_mentions" },
        { name = "avante_files" },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        -- None of this made sense to me when first looking into this since there
        -- is no vim docs, but you can't have select = true here _unless_ you are
        -- also using the snippet stuff. So keep in mind that if you remove
        -- snippets you need to remove this select
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-space>"] = cmp.mapping.complete(),
      }),
      -- mapping = {
      --   ["<C-d>"] = cmp..mapping.scroll_docs(-4),
      -- 	["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- 	["<C-e>"] = cmp.mapping.abort(),
      -- 	["<C-n>"] = cmp.mapping(function(fallback)
      -- 		if cmp.visible() then
      -- 			cmp.select_next_item()
      -- 		else
      -- 			fallback()
      -- 		end
      -- 	end, { "i", "s" }),
      -- 	["<C-p>"] = cmp.mapping.select_prev_item(),
      -- 	["<C-y>"] = cmp.mapping.confirm({
      -- 		behavior = cmp.ConfirmBehavior.Insert,
      -- 		select = true,
      -- 	}),
      -- 	["<C-space>"] = cmp.mapping.complete(),
      -- },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    -- https://www.reddit.com/r/neovim/comments/111xoy0/how_do_i_match_hover_lsp_ui_like_nvimcmp/?chainedPosts=t3_128s4pz
    -- vim.cmd(":set winhighlight=" .. cmp.config.window.bordered().winhighlight)
  end,
}
