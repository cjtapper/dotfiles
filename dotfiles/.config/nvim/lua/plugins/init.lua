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
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      local conditional = function(fn)
        local utils = require("null-ls.utils").make_conditional_utils()
        return fn(utils)
      end

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.rubocop,
        },

        -- Here we set a conditional to call the rubocop formatter. If we have a Gemfile in the project, we call "bundle exec rubocop", if not we only call "rubocop".
        conditional(function(utils)
          return utils.root_has_file("Gemfile")
            and null_ls.builtins.formatting.rubocop.with({
              command = "bundle",
              args = vim.list_extend(
                { "exec", "rubocop" },
                null_ls.builtins.formatting.rubocop._opts.args
              ),
            })
            or null_ls.builtins.formatting.rubocop
        end),

        -- Same as above, but with diagnostics.rubocop to make sure we use the proper rubocop version for the project
        conditional(function(utils)
          return utils.root_has_file("Gemfile")
            and null_ls.builtins.diagnostics.rubocop.with({
              command = "bundle",
              args = vim.list_extend(
                { "exec", "rubocop" },
                null_ls.builtins.diagnostics.rubocop._opts.args
              ),
            })
            or null_ls.builtins.diagnostics.rubocop
        end),

      })
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true
  },
  "alvan/vim-closetag",
  "lukas-reineke/indent-blankline.nvim",
  "raimon49/requirements.txt.vim",
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gb", ":Git blame<cr>")
    end
  },
  "tpope/vim-unimpaired",
  "tummetott/reticle.nvim",
}
