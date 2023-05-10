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
