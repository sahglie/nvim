return {
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = ';',
      },
      opleader = {
        line = '<c-;>',
      }
    },
    -- Add your custom configuration after the plugin loads
    config = function(_, opts)
      -- Setup with the default options first
      require('Comment').setup(opts)

      -- Add your custom mapping for visual mode
      vim.keymap.set('x', '<C-;>', '<Plug>(comment_toggle_linewise_visual)', { silent = true })
    end,
  }
}
