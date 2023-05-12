local dracula = require('dracula')
local colors = dracula.colors()

dracula.setup({
  overrides = {
    ColorColumn = {bg = colors.menu},
  }
})
vim.cmd.colorscheme('dracula')
