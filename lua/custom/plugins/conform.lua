return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        ruby = { "rubocop" },
      },
    })

    vim.keymap.set("n", "\\", conform.format, {})

    --vim.api.nvim_create_autocmd("BufWritePre", {
    --  pattern = "*.rb",
    --  callback = function(args)
    --    require("conform").format({ bufnr = args.buf })
    --  end,
    --})
  end
}
