return {
  'nvim-lualine/lualine.nvim',
  config = function ()
    require('lualine').setup{
      options = {
        theme = 'auto',
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
          {
            'filename',
            path = 1, -- 1: Relative path
          },
          'diff',
          'diagnostics',
        },
        lualine_x = {'encoding', 'filetype'},
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
      },
    }
  end
}
