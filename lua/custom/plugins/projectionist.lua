return {
  "tpope/vim-projectionist",
  config = function()
    -- Configure projectionist
    vim.g.projectionist_heuristics = {
      ["*.go"] = {
        ["*.go"] = {
          ["alternate"] = "{}_test.go",
          ["type"] = "source"
        },
        ["*_test.go"] = {
          ["alternate"] = "{}.go",
          ["type"] = "test"
        }
      }
    }
  end
}
