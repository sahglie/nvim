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
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },

      follow_current_file = {
        enable = true,
      },

      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })

    vim.keymap.set("c", "tt", ":Neotree filesystem reveal toggle left<CR>", {})
    vim.keymap.set('n', 'F', ':Neotree reveal<CR>', { desc = 'Reveal current file in neotree' })
    --vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal toggle float<CR>", {})
  end
}
