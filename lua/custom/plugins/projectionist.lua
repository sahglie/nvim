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
      },
      ["*.rb"] = {
        ["lib/*.rb"] = {
          ["alternate"] = "test/{}_test.rb",
          ["type"] = "source"
        },
        ["test/*_test.rb"] = {
          ["alternate"] = "lib/{}.rb",
          ["type"] = "test"
        }
      },
    }
  end
}
