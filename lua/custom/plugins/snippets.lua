return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Provides a large collection of snippets
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    vim.keymap.set("n", "<leader>ss", function()
      require("luasnip.loaders").edit_snippet_files()
    end)
    -- Assuming your snippet file is in ~/.config/nvim/lua/snippets/go.lua
    require("luasnip").add_snippets("go", require("snippets.go"))
  end,
}
