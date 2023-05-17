return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {'L3MON4D3/LuaSnip'},
  },
  config = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local cmp = require('cmp')
    local cmp_select_behavior = {behavior = cmp.SelectBehavior.Insert}
    local cmp_mappings = {
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_behavior),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select_behavior),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp_mappings
    })
  end
}
