return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    local nvim_tmux = require("nvim-tmux-navigation")
    nvim_tmux.setup({ disable_when_zoomed = true })

    vim.defer_fn(function()
      -- NvimTmuxNaviator
      vim.keymap.set("n", "<C-h>", nvim_tmux.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux.NvimTmuxNavigateDown)
      --vim.keymap.set("n", "<C-k>", nvim_tmux.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux.NvimTmuxNavigateRight)
    end, 100)
  end,
}
