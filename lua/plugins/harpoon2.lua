return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {}, -- This disables LazyVim's default keys
  config = function()
    require("lazyvim.plugins.extras.editor.harpoon").config()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Your custom keymaps here
    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
  end,
}
