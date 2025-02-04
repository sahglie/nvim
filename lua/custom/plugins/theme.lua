--return {
--  {
--    "folke/tokyonight.nvim",
--    config = function()
--      vim.cmd.colorscheme "tokyonight"
--    end
--  }
--}

return {
  {
    "sahglie/darcula-dark.nvim",
    priority = 1000,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local darcula = require("darcula")
      darcula.setup({})
      vim.cmd.colorscheme("darcula-dark")
    end,
  },
}
