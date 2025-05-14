return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "c",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "typescript",
        "vim",
        "vimdoc",
        "query",
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          scope_incremental = "grc",
          node_incremental = "gnn",
          node_decremental = "grn",
        },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]c"] = { query = { "@comment", "@docstring" }, desc = "Comment forward" },
            ["]m"] = { query = "@function.outer", desc = "Function forward" },
            ["]]"] = { query = "@class.outer", desc = "Class forward" },
          },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Function forward end" },
            ["]["] = { query = "@class.outer", desc = "Class forward end" },
          },
          goto_previous_start = {
            ["[c"] = { query = { "@comment", "@docstring" }, desc = "Comment backward" },
            ["[m"] = { query = "@function.outer", desc = "Function backward" },
            ["[["] = { query = "@class.outer", desc = "Class backward" },
          },
          goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Function backward end" },
            ["[]"] = { query = "@class.outer", desc = "Class backward end" },
          },
        },
      },
    }
  end
}
