return {
  "tpope/vim-surround",
  {"tpope/vim-rails", enabled = false },
  config = function()
    require("vim-rails").setup({})
  end
}
