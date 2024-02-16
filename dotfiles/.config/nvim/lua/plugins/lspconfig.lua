return {
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({
        settings = {
          -- Fix Undefined global 'vim'
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      -- Note: Plugins for black, isort, flake8 need to be installed in the same
      -- venv as pylsp.
      -- Make sure you use the ones prefixed with "python-lsp-", not "pyls-"
      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            -- configurationSources = {'flake8'},
            plugins = {
              black = { enabled = false },
              flake8 = { enabled = false },
              isort = { enabled = false },
              rope_autoimport = { enabled = true },
              mccabe = { enabled = false },
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
            }
          },
        }
      })

      lspconfig.solargraph.setup({
        settings = {
          diagnostics = false,
        }
      })

      vim.fn.sign_define({
        { name = 'error', text = 'E', hl = 'DiagnosticSignError', numhl = nil },
        { name = 'hint',  text = 'H', hl = 'DiagnosticSignHint',  numhl = nil },
        { name = 'info',  text = 'I', hl = 'DiagnosticSignInfo',  numhl = nil },
        { name = 'warn',  text = 'W', hl = 'DiagnosticSignWarn',  numhl = nil },
      })

      vim.diagnostic.config({
        virtual_text = true
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local bufnr = ev.buf
          local opts = { buffer = bufnr, remap = false }
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.format({ timeout_ms = 3000 }) end, opts)

          -- Highlight current variable and usages on CursorHold
          if client.server_capabilities.documentHighlightProvider then
            vim.cmd([[
            hi! link LspReferenceRead Visual
            hi! link LspReferenceText Visual
            hi! link LspReferenceWrite Visual
            ]])

            local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_create_autocmd("CursorHold", {
              group = gid,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.document_highlight()
              end
            })

            vim.api.nvim_create_autocmd("CursorMoved", {
              group = gid,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.clear_references()
              end
            })
          end

          -- Format on save
          if client.supports_method("textDocument/formatting") then
            local gid = vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_clear_autocmds({ group = gid, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = gid,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end
  }
}
