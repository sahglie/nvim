return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      codelens = { enabled = true },
      setup = {
        ruby_lsp = function(_, _)
          vim.lsp.commands["rubyLsp.openFile"] = function(cmd, _)
            local uri_frag = cmd.arguments[1][1]
            local uri, line = uri_frag:match("^(.+)#L(%d+)$")
            if not uri then
              uri = uri_frag
            end
            local bufnr = vim.uri_to_bufnr(uri)
            vim.fn.bufload(bufnr)
            vim.api.nvim_set_option_value("buflisted", true, { buf = bufnr })
            vim.api.nvim_set_current_buf(bufnr)

            vim.api.nvim_win_set_cursor(0, { tonumber(line) or 1, 0 })
          end
        end,

        -- Add your custom LSP here
      },
      servers = {
        -- ruby_lsp = {
        --   mason = false,
        --   cmd = { "bundle", "exec", "ruby-lsp" },
        --   init_options = {
        --     formatter = "standard",
        --     testRunner = true,
        --     addonSettings = { ["Ruby LSP Rails"] = { enablePendingMigrationsPrompt = false } },
        --   },
        -- },
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
        educationalsp = {},
        marksman = false,
      },
    },
  },
}
