return {
  "folke/which-key.nvim",
  keys = {
    {
      "<space>", -- or any other key you want
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show Which-Key root menu",
    },
  },
}
