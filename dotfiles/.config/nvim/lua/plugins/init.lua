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
          ColorColumn = {bg = colors.menu},
        }
      })
      vim.cmd.colorscheme('dracula')
    end
  },
  {
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    "tummetott/reticle.nvim",
    opts = { disable_in_insert = false }
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
    "windwp/nvim-autopairs",
    config = true,
  },
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
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup{
        on_attach = function(bufnr)
          vim.keymap.set({"n", "x"}, "<leader>ghr", gitsigns.reset_hunk, {buffer=bufnr})

           -- Navigation
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, buffer=buffnr})

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, buffer=buffnr})
        end
      }
    end
  },
  "alvan/vim-closetag",
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
}
