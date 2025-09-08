return {
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = ";",
      },
      opleader = {
        line = ";",
      },
    },
    -- Add your custom configuration after the plugin loads
    config = function(_, opts)
      -- Setup with the default options first
      require("Comment").setup(opts)
    end,
  },
}
