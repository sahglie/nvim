return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", lazy = false },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      default_file_explorer = true,
      keymaps = {
        ["L"] = "actions.preview",
        ["U"] = "actions.parent",
        ["R"] = "actions.refresh",
      },
    })
  end,
  lazy = false,
}
