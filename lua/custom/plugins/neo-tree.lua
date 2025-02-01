return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })

    vim.keymap.set("n", "<leader>1", ":Neotree filesystem reveal toggle left<CR>", {})
    --vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal toggle float<CR>", {})
  end
}
