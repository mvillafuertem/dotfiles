return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
    -- Load custom VSCode-format snippets from ~/.config/nvim/snippets/
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    -- Jump forward/backward through tabstops
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if luasnip.jumpable(1) then luasnip.jump(1) end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if luasnip.jumpable(-1) then luasnip.jump(-1) end
    end, { silent = true })
  end,
}
