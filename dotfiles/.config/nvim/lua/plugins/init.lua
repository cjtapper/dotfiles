return {
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local dracula = require('dracula')
      local colors = dracula.colors()

      dracula.setup({
        overrides = {
          ColorColumn = { bg = colors.menu },
        }
      })
      vim.cmd.colorscheme('dracula')
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
    "aserowy/tmux.nvim",
    config = true,
    lazy = false,
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
  { -- Optional
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
    config = true
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup {
        on_attach = function(bufnr)
          vim.keymap.set({ "n", "x" }, "<leader>ghr", gitsigns.reset_hunk, { buffer = bufnr })
          vim.keymap.set({ "n", "x" }, "<leader>gbr", gitsigns.reset_buffer, { buffer = bufnr })

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
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gb", ":Git blame<cr>")
    end
  },
  "tpope/vim-unimpaired",
  {
    "slim-template/vim-slim",
    ft = { "slim" },
  },
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
          require("none-ls.diagnostics.ruff"),
          require("none-ls.formatting.ruff_format"),
          none_ls.builtins.formatting.black,
          none_ls.builtins.formatting.isort,
        },
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "zbirenbaum/copilot.lua",
    command = "Copilot",
    event = { "InsertEnter" },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = false,
      },
    },
  },
}
