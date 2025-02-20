return {
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/nvim-cmp"
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup {
        ensure_installed = { 'gofumpt', 'goimports', 'goimports-revised' },
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'gopls', 'ruby_lsp', 'html' },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          }
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      local util = require('lspconfig/util')

      lspconfig.lua_ls.setup { capabilities = capabilities }

      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        --on_attach = function(client, _)
        --  client.server_capabilities.documentFormattingProvider = true
        --  client.server_capabilities.documentRangeFormattingProvider = true
        --end,
        cmd = { os.getenv("HOME") .. "/.local/share/mise/installs/ruby/3.4.1/bin/ruby-lsp" },
        settings = {
          formatter = {
            enable = true,
          }
        }
      })

      lspconfig.templ.setup { capabilities = capabilities }

      lspconfig.gopls.setup {
        --on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      }

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded', -- You can choose 'single', 'double', 'rounded', 'solid', 'shadow'
        width = 80,         -- Set the width of the floating window
        height = 20,        -- Set the height of the floating window
      })

      vim.lsp.handlers['textDocument/completion'] = vim.lsp.with(vim.lsp.handlers.completion, {
        border = 'rounded', -- You can choose 'single', 'double', 'rounded', 'solid', 'shadow'
        width = 60,         -- Set the width of the floating window
        height = 20,        -- Set the height of the floating window
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { 'source.organizeImports' } }
          -- buf_request_sync defaults to a 1000ms timeout. Depending on your
          -- machine and codebase, you may want longer. Add an additional
          -- argument after params if you find that you have to write the file
          -- twice for changes to be saved.
          -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
          local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          vim.lsp.buf.format { async = false }
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if vim.bo.filetype == "lua" and client.supports_method("textDocument/formatting") then
            -- format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
            --vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          end
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if vim.bo.filetype == "ruby" and client.supports_method("textDocument/formatting") then
            -- format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end,
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<C-CR>', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', 'c-\\', vim.lsp.buf.format, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    end,
  },
}
