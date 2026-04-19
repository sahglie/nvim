return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim", -- Optional but highly recommended for the picker
  },
  config = function()
    require("opencode").setup({
      -- Points to the brew-installed binary you just set up
      opencode_executable = "opencode",
      ui = {
        position = "right",
        width = 40,
      },
      keymap_prefix = "<leader>o", -- Prefix for all OpenCode commands
    })
  end,
}
