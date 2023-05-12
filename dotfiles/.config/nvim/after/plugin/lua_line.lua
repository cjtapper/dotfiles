local dracula = require("dracula")
local configs = dracula.configs()
local colors = dracula.colors()

local bg = configs.lualine_bg_color or colors.black

require('lualine').setup {
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
    lualine_x = {'encoding', 'filetype'}
  }
}
