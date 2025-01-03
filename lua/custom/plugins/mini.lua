return {
  {
    "echasnivski/mini.nvim",
    url = 'git@github.com:echasnovski/mini.nvim.git',
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup { use_icons = true }
    end
  }
}
