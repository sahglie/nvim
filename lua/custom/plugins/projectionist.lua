return {
  "tpope/vim-projectionist",

  config = function()
    -- Configure projectionist
    --vim.g.projectionist_heuristics = {
    --  ["*.go"] = {
    --    ["*.go"] = {
    --      ["alternate"] = "{}_test.go",
    --      ["type"] = "source"
    --    },
    --    ["*_test.go"] = {
    --      ["alternate"] = "{}.go",
    --      ["type"] = "test"
    --    }
    --  }
    --}

    --local function is_rails_project()
    --  return vim.fn.filereadable("bin/rails") == 1
    --end

    ---- Only add Ruby mappings if not in a Rails project
    --if not is_rails_project() then
    --  vim.g.projectionist_heuristics["*.rb"] = {
    --    ["lib/*.rb"] = {
    --      ["alternate"] = "test/{}_test.rb",
    --      ["type"] = "source"
    --    },
    --    ["test/*_test.rb"] = {
    --      ["alternate"] = "lib/{}.rb",
    --      ["type"] = "test"
    --    }
    --  }
    --end
  end
}
