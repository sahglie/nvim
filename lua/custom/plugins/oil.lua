return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons",     lazy = false },
    { "nvim-tree/nvim-web-devicons" }
  },
  config = function()
    local oil = require("oil")
    oil.setup({
      view_options = {
        show_hidden = true
      },
      default_file_explorer = true,
      keymaps = {
        ["L"] = "actions.preview",
        ["U"] = "actions.parent",
        ["R"] = "actions.refresh",
      },
    })
    --vim.keymap.set("n", "-", oil.toggle_float, {})
    vim.keymap.set("n", "<leader>1", oil.toggle_float, {})
  end,
  lazy = false,
}
