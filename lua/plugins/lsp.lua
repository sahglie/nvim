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

          -- vim.api.nvim_create_autocmd("LspAttach", {
          --   callback = function(args)
          --     local client = vim.lsp.get_client_by_id(args.data.client_id)
          --     if client and client.name == "ruby_lsp" then
          --       vim.notify("Ruby LSP Commands: " .. vim.inspect(client.server_capabilities.executeCommandProvider))
          --     end
          --   end,
          -- })
        end,
      },
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { "bundle", "exec", "ruby-lsp" },
          init_options = {
            formatter = "standard",
            addonSettings = { ["Ruby LSP Rails"] = { enablePendingMigrationsPrompt = false } },
          },
        },
      },
    },
  },
}
