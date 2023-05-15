local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp_zero.preset("recommended")

lsp_zero.ensure_installed({
  'lua_ls',
  'solargraph',
  'tsserver',
})

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

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true
        },
        flake8 = {
          enabled = true
        },
        isort = {
          enabled = true
        },
        mccabe = {
          enabled = false
        },
        pyflakes = {
          enabled = false
        },
        pycodestyle = {
          enabled = false
        },
        rope_autoimport = {
          enabled = true
        }
      }
    },
  }
})

lspconfig.solargraph.setup({
  settings= {
    diagnostics = true,
  }
})

lsp_zero.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp_zero.on_attach(function(client, bufnr)
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

vim.diagnostic.config({
    virtual_text = true
})

vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format()]]
