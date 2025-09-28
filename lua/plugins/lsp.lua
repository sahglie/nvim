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

        -- Add your custom LSP here
        educationalsp = function(_, _)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")

          if not configs.educationalsp then
            configs.educationalsp = {
              default_config = {
                cmd = { "/home/sah/Development/projects/go-lsp-tut/main" },
                filetypes = { "markdown", "md" },
                single_file_support = true,
              },
            }
          end

          vim.notify("Setting up educationalsp")
          lspconfig.educationalsp.setup({
            -- on_attach = function(client, bufnr)
            --   vim.notify("educationalsp attached to markdown file: " .. bufnr)
            -- end,
            -- on_exit = function(code, signal, client_id)
            --   vim.notify("educationalsp exited with code: " .. code)
            -- end,
            -- on_error = function(err)
            --   vim.notify("educationalsp error: " .. vim.inspect(err))
            -- end,
          })
        end,
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
