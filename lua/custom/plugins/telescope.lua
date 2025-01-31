return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function()
    require("telescope").setup {
      pickers = {
        find_files = {}
      },
      extensions = {
        fzf = {}
      }
    }

    require("telescope").load_extension("fzf")

    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
    vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
    vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps)
    vim.keymap.set("n", "<leader>fa", require("telescope.builtin").commands)
    vim.keymap.set("n", "<leader>en", function()
      local opts = require("telescope.themes").get_ivy({
        cwd = vim.fn.stdpath("config")
      })

      require("telescope.builtin").find_files(opts)
    end)

    vim.keymap.set("n", "<leader>ef", function()
      local opts = require("telescope.themes").get_ivy({
        cwd = os.getenv("HOME") .. "/.config/fish"
      })
      require("telescope.builtin").find_files(opts)
    end)

    require("config.telescope.multigrep").setup()
  end
}
