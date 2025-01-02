return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        }
      },
    },
    config = function()
      -- needs "lua-language-server" installed
      -- confirm install with:
      -- :echo executable("lua-language-server") => 1
      require'lspconfig'.lua_ls.setup {}
    end
  }
}
