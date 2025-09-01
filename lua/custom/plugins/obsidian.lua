return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "sahglie-vault",
        path = os.getenv("HOME") .. "/Development/projects/obsidian-vault",
      }
    },
    daily_notes = {
      folder = "UCB/TODOs",
      date_format = "%Y-%m-%d"
    },

  }
}
