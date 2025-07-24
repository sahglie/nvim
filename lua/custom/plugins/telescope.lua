return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function()
    require("telescope").setup {
      defaults = {
        -- These patterns are respected by default by all pickers
        file_ignore_patterns = {
          "^.git/",
        },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
            border = true,
          },
        },
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",
        }
      }
    }

    require("telescope").load_extension("fzf")

    vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags)
    vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers)
    vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
    vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>fi", function()
      require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = {
          "%.git/",
          "%.idea/",
          "node_modules/",
          "^tmp/"
        },
      })
    end)
    vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps)
    vim.keymap.set("n", "<leader>sa", require("telescope.builtin").commands)
    vim.keymap.set("n", "<leader>G", require("telescope.builtin").commands)
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
