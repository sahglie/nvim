-- Check if the directory exists first
local plugin_path = vim.fn.expand("~/Development/projects/railsjump.nvim")
if vim.fn.isdirectory(plugin_path) == 0 then
  vim.notify("RailsJump directory does not exist: " .. plugin_path, vim.log.levels.WARN)
  return {}
end


return {
  dir = plugin_path,
  name = "railsjump.nvim",
  dev = true, -- Tells lazy.nvim this is a development plugin
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require('railsjump').setup({
      -- Custom configuration options
      items = { "Steven", "Dorian", "Ming", "Custom Item" },
      title = "My RailsJump",
      default_keybind = "<leader>rj", -- Set to false to disable
    })
  end,
  -- Lazy loading options (optional but good for performance)
  cmd = {
    "RailsJumpToggle",
    "RailsJumpSetup",
    "RailsJumpConfig"
  },
  keys = {
    { "<leader>rj", desc = "Toggle RailsJump" }
  }
}
