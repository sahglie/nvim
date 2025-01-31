return {
  {
    "nvim-tree/nvim-tree.lua",
    url = 'git@github.com:nvim-tree/nvim-tree.lua.git',
    config = function()
      require('nvim-tree').setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
        }
      })
    end
  }
}
