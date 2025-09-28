return {
  "ThePrimeagen/harpoon",
  keys = {
    -- Keep the ones you want
    {
      "<leader>H",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon File",
    },
    {
      "<leader>h",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon Quick Menu",
    },
    -- Disable the number keys
    { "<leader>1", false },
    { "<leader>2", false },
    { "<leader>3", false },
    { "<leader>4", false },
    { "<leader>5", false },
    { "<leader>6", false },
    { "<leader>7", false },
    { "<leader>8", false },
    { "<leader>9", false },
  },
}
