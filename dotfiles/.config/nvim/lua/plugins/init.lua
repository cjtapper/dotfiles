return {
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = false
      vim.g.everforest_background = 'hard'
      vim.cmd.colorscheme('everforest')
    end
  },
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        custom_textobjects = {
          c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
          m = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
          o = spec_treesitter({
            a = { '@conditional.outer', '@contextmanager.outer', '@loop.outer' },
            i = { '@conditional.inner', '@contextmanager.inner', '@loop.inner' },
          }),
        }
      })
    end,
  },
  {
    'echasnovski/mini.bracketed',
    version = '*',
    config = {
      comment = { suffix = '' } -- disable in favour of my treesitter version
    },
  },
  {
    'echasnovski/mini.clue',
    version = '*',
    config = function()
      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          { mode = 'n', keys = '<space>' },
          { mode = 'x', keys = '<space>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- Bracketed
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
        },
        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
    end
  },
  {
    'echasnovski/mini.icons',
    version = '*',
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
    end
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    config = function()
      local indentscope = require('mini.indentscope')
      indentscope.setup({
        draw = {
          animation = indentscope.gen_animation.none(),
        },
        symbol = "│",
      })
    end
  },
  { 'echasnovski/mini.pairs',     version = '*', config = true },
  { 'echasnovski/mini.splitjoin', version = '*', config = true },
  { 'echasnovski/mini.surround',  version = '*', config = true },
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
          vim.keymap.set({ "n", "x" }, "<leader>grh", gitsigns.reset_hunk, { buffer = bufnr })
          vim.keymap.set({ "n", "x" }, "<leader>grb", gitsigns.reset_buffer, { buffer = bufnr })
          vim.keymap.set({ "n", "x" }, "<leader>gb", gitsigns.blame, { buffer = bufnr })

          -- Navigation
          vim.keymap.set('n', ']h', function()
            if vim.wo.diff then return ']h' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = "Hunk forward" })

          vim.keymap.set('n', '[h', function()
            if vim.wo.diff then return '[h' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = "Hunk backward" })
        end
      }
    end
  },
  "raimon49/requirements.txt.vim",
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
  {
    "windwp/nvim-ts-autotag",
    config = true,
  },
  "lbrayner/vim-rzip", -- Required for typescript-language-server to work - see https://yarnpkg.com/getting-started/editor-sdks#neovim-native-lsp
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
}
