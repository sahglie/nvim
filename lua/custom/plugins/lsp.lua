-- =============================================================================
-- LSP AND AUTOCOMPLETION CONFIGURATION
-- =============================================================================
-- This file configures the Neovim LSP client, the Mason package manager
-- for installing LSPs, and the nvim-cmp autocompletion engine.
-- =============================================================================

return {
  -----------------------------------------------------------------------------
  -- LSP SERVER MANAGEMENT & CONFIGURATION
  -----------------------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',           version = 'v2.0.1' },
      { 'williamboman/mason-lspconfig.nvim', version = 'v2.1.0' },
      { 'j-hui/fidget.nvim',                 opts = {} },
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- This function is called by the LspAttach event and contains our keymaps
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then desc = 'LSP: ' .. desc end
          vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
        nmap('<leader>d', vim.diagnostic.open_float, '[D]iagnostics')
        nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
        nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')

        if client:supports_method 'textDocument/formatting' then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, { clear = true }),
            buffer = bufnr,
            callback = function()
              if client.name == 'gopls' then
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { 'source.organizeImports' } }
                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
                if result and result[1] and result[1].result then
                  local enc = (vim.lsp.get_client_by_id(client.id) or {}).offset_encoding or 'utf-16'
                  vim.lsp.util.apply_workspace_edit(result[1].result.edit, enc)
                end
              end
              vim.lsp.buf.format { async = false, bufnr = bufnr }
            end,
          })
        end
      end

      -- Configure diagnostic icons
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
          },
        },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

      -- Setup Mason and mason-lspconfig
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'gopls', 'ruby_lsp', 'pyright', 'templ' },
        automatic_enable = true,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'

      -- Apply custom settings and on_attach to servers.
      -- This merges with the automatic setup from mason-lspconfig.

      local servers = { 'lua_ls', 'gopls', 'ruby_lsp', 'pyright', 'templ' }
      for _, server_name in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        if server_name == 'gopls' then
          opts.settings = { gopls = { completeUnimported = true, usePlaceholders = true, analyses = { unusedparams = true } } }
          lspconfig[server_name].setup(opts)
          -- elseif server_name == 'ruby_lsp' then
          --   opts.init_options = { enabledFeatures = { 'rails' }, addonSettings = { ['Ruby LSP Rails'] = { enablePendingMigrationsPrompt = false } } }
          --   lspconfig[server_name].setup(opts)
        elseif server_name == 'lua_ls' then
          opts.settings = { Lua = { runtime = { version = 'LuaJIT' }, workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } } } }
          lspconfig[server_name].setup(opts)
        end
      end
    end,
  },

  -----------------------------------------------------------------------------
  -- AUTOCOMPLETION ENGINE (NVIM-CMP)
  -----------------------------------------------------------------------------
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- This function will jump forward through snippet placeholders.
      -- It will expand a snippet if the cursor is at the end of one.
      local luasnip_expand_or_jump = function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end

      -- This function will jump backward through snippet placeholders.
      local luasnip_jump_prev = function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end

      cmp.setup {
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          -- Use the named functions here for clarity and correctness
          ['<C-l>'] = cmp.mapping(luasnip_expand_or_jump, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(luasnip_jump_prev, { 'i', 's' }),
        },
        sources = { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'path' } },
      }
    end,
  },
}
