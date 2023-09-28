return {
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
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-x>"] = "delete_buffer",
            }
          }
        }
      }
    }
    telescope.load_extension('fzf')

    -- Use git_files if in a git repo,
    local project_files = function()
      vim.fn.system('git rev-parse --is-inside-work-tree')
      if vim.v.shell_error == 0 then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end

    vim.keymap.set('n', '<C-p>', project_files, {})
    vim.keymap.set('n', '<C-/>', builtin.live_grep, {})
    vim.keymap.set('n', '<C-_>', builtin.live_grep, {})
    vim.keymap.set('n', '<C-b>', builtin.buffers, {})
    vim.keymap.set('n', '<leader>s', builtin.treesitter, {})
    vim.keymap.set('n', '<leader>*', builtin.grep_string, {})
  end
}
