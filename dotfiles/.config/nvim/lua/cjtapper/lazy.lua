local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local dracula = require('dracula')
      local colors = dracula.colors()

      dracula.setup({
        overrides = {
          ColorColumn = {bg = colors.menu},
        }
      })
      vim.cmd.colorscheme('dracula')
    end
  },
  'lukas-reineke/indent-blankline.nvim',
  {'numToStr/Comment.nvim', config = true},
  {
    "tummetott/reticle.nvim",
    opts = { disable_in_insert = false }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {{ 'nvim-tree/nvim-web-devicons', lazy = true }},
    config = function ()
      local dracula = require("dracula")
      local configs = dracula.configs()
      local colors = dracula.colors()

      local bg = configs.lualine_bg_color or colors.black

      require('lualine').setup{
        options = {
          theme = 'dracula-nvim',
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_b = {
            {
              'filename',
              path = 1, -- 1: Relative path
              color = { fg = colors.white, bg = bg },
            },
          },
          lualine_c = {'diff', 'diagnostics'},
          lualine_x = {'encoding', 'filetype'},
        },
        inactive_sections = {
          lualine_c = {
            {
                'filename',
                path = 1,
            },
          },
        },
      }
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
      'RRethy/nvim-treesitter-endwise'
    },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "c",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "typescript",
          "vim",
          "vimdoc",
          "query",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
      }
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = { separator = "─" },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    opts = { use_default_keymaps = false },
    config = function()
      local treesj = require('treesj')
      vim.keymap.set("n", "<leader>jj", treesj.toggle)
    end
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = true,
  },
  {
    "aserowy/tmux.nvim",
    config = true,
    lazy = false,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')

      telescope.setup{
        defaults = {
          mappings = {
            i = {
              ["<Esc>"] = actions.close
            }
          }
        },
      }
      telescope.load_extension('fzf')

      -- Use git_files if in a git repo,
      local project_files = function()
        vim.fn.system('git rev-parse --is-inside-work-tree')
        if vim.v.shell_error == 0 then
          require"telescope.builtin".git_files()
        else
          require"telescope.builtin".find_files()
        end
      end

      vim.keymap.set('n', '<C-p>', project_files, {})
      vim.keymap.set('n', '<C-/>', builtin.live_grep, {})
      vim.keymap.set('n', '<C-_>', builtin.live_grep, {})
      vim.keymap.set('n', '<C-b>', builtin.buffers, {})
      vim.keymap.set('n', '<leader>s', builtin.treesitter, {})
    end
  },
  "alvan/vim-closetag",
  "raimon49/requirements.txt.vim",
  "tpope/vim-fugitive",
  "tpope/vim-unimpaired",
  "tummetott/reticle.nvim",
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#python#pytest#file#pattern"] = [[\v(test_[^/]+|[^/]+_test|tests)\.py$]]
      vim.g["test#python#runner"] = 'pytest'
      vim.g["test#python#pytest#options"] = {
        all = '--reuse-db',
        nearest = '-p no:warnings',
      }
      vim.g["test#strategy"] = "neovim"
      vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true })
    end
  },
  "windwp/nvim-autopairs",
  {                                      -- Optional
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
    config = true
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      require('lsp-zero.settings').preset("minimal")
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()

      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local cmp = require('cmp')
      local cmp_select_behavior = {behavior = cmp.SelectBehavior.Insert}
      local cmp_mappings = {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_behavior),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select_behavior),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp_mappings
      })
    end
  },
  -- LSP
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
  },
}

require('lazy').setup(plugins)
