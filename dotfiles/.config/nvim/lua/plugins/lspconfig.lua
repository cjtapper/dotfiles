return  {
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
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

      lspconfig.pyright.setup({})
      lspconfig.solargraph.setup({
        settings= {
          diagnostics = true,
        }
      })

      vim.fn.sign_define({
        {name = 'error', text = 'E', hl = 'DiagnosticSignError', numhl = nil},
        {name = 'hint',  text = 'H', hl = 'DiagnosticSignHint',  numhl = nil},
        {name = 'info',  text = 'I', hl = 'DiagnosticSignInfo',  numhl = nil},
        {name = 'warn',  text = 'W', hl = 'DiagnosticSignWarn',  numhl = nil},
      })

      vim.diagnostic.config({
        virtual_text = true
      })

      lsp_zero.on_attach(function(_, bufnr)
        local opts = {buffer = bufnr, remap = false}

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
      end)

      lsp_zero.setup()
    end
  }
}
