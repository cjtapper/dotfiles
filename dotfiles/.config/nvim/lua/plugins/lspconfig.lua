return {
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
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
              autopep8 = { enabled = false },
              black = { enabled = false },
              flake8 = { enabled = false },
              isort = { enabled = false },
              rope_autoimport = { enabled = true },
              mccabe = { enabled = false },
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              yapf = { enabled = false },
            }
          },
        }
      })

      -- lspconfig.ruff.setup({
      -- })

      lspconfig.ts_ls.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
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
        callback = function(event)
          local bufnr = event.buf
          local opts = { buffer = bufnr, remap = false }

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then return end

          vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<M-k>", function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set("i", "<M-k>", function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set("n", "<space>a", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<space>r", function() vim.lsp.buf.rename() end, opts)

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
