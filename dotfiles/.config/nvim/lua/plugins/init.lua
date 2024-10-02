return {
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = 'hard'
      vim.cmd.colorscheme('everforest')
    end
  },
  {
    "tummetott/reticle.nvim",
    opts = {
      on_startup = {
        cursorline = true,
      },
      disable_in_insert = false,
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = true,
  },
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        custom_textobjects = {
          c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
          f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
          o = spec_treesitter({
            a = { '@conditional.outer', '@contextmanager.outer', '@loop.outer' },
            i = { '@conditional.inner', '@contextmanager.inner', '@loop.inner' },
          }),
        }
      })
    end,
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = true,
  },
  { 'echasnovski/mini.splitjoin', version = '*', config = true },
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#python#pytest#file_pattern"] = [[\v(test_[^/]+|[^/]+_test|tests)\.py$]]
      vim.g["test#python#runner"] = 'pytest'
      vim.g["test#python#pytest#options"] = {
        nearest = '-p no:warnings',
      }
      vim.g["test#strategy"] = "neovim"
      vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true })
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup {
        on_attach = function(bufnr)
          vim.keymap.set({ "n", "x" }, "<leader>ghr", gitsigns.reset_hunk, { buffer = bufnr })
          vim.keymap.set({ "n", "x" }, "<leader>gbr", gitsigns.reset_buffer, { buffer = bufnr })
          vim.keymap.set({ "n", "x" }, "<leader>gb", gitsigns.blame, { buffer = bufnr })

          -- Navigation
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })
        end
      }
    end
  },
  "alvan/vim-closetag",
  "raimon49/requirements.txt.vim",
  "tpope/vim-unimpaired",
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local none_ls = require("null-ls")
      none_ls.setup({
        sources = {
          require("none-ls.diagnostics.flake8"),
          -- TODO: use ruff lsp instead of none ls
          -- require("none-ls.diagnostics.ruff"),
          -- require("none-ls.formatting.ruff_format"),
          none_ls.builtins.formatting.isort,
          none_ls.builtins.formatting.black,
        },
      })
    end
  },
}
