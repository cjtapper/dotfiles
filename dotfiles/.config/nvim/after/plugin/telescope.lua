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

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-P>', builtin.find_files, {})
vim.keymap.set('n', '<C-/>', builtin.live_grep, {})
vim.keymap.set('n', '<C-_>', builtin.live_grep, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<leader>s', builtin.treesitter, {})
