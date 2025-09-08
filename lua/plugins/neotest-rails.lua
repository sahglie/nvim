return {
  -- Specify the plugin we're configuring
  "nvim-neotest/neotest",

  -- Add the Minitest adapter as a dependency.
  -- LazyVim will ensure this is installed alongside neotest.
  dependencies = {
    "nvim-neotest/neotest-minitest",
    url = "git@github.com:zidhuss/neotest-minitest.git",
  },

  -- The 'opts' table gets merged with the default LazyVim configuration.
  opts = {
    adapters = {
      ["neotest-minitest"] = {
        -- This is the crucial part for Rails. It tells the adapter
        -- to run tests using the Rails runner, which loads the
        -- full application environment.
        test_cmd = "bundle exec bin/rails test",
      },
    },
  },
  -- Add your own keymaps here
  -- keys = {
  --   {
  --     "<leader>rt",
  --     function()
  --       require("neotest").run.run()
  --     end,
  --     desc = "Run Nearest Test",
  --   },
  --   {
  --     "<leader>rT",
  --     function()
  --       require("neotest").run.run(vim.fn.expand("%"))
  --     end,
  --     desc = "Run Tests in Current File",
  --   },
  --   {
  --     "<leader>rs",
  --     function()
  --       require("neotest").run.run_last()
  --     end,
  --     desc = "Run Last Test",
  --   },
  --   {
  --     "<leader>ro",
  --     function()
  --       require("neotest").output.open({ enter = true })
  --     end,
  --     desc = "Open Test Output",
  --   },
  --   {
  --     "<leader>rS",
  --     function()
  --       require("neotest").summary.toggle()
  --     end,
  --     desc = "Toggle Test Summary",
  --   },
  -- },
}
