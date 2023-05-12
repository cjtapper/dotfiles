require('lualine').setup {
  options = {
    theme = 'dracula-nvim',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_x = {'encoding', 'filetype'}
  }
}
