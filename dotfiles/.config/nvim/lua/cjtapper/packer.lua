-- Automatically bootstrap packer.nvim
-- See: https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {'dracula/vim', as = 'dracula'} -- I prefer the colors in this over the nvim specific one below

  use {
    'nvim-treesitter/nvim-treesitter',
    {run = ':TSUpdate'}
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  use 'mbbill/undotree'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
      enable_check_bracket_line = true,
      check_ts = true
    } end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use "Glench/Vim-Jinja2-Syntax"
  use "alvan/vim-closetag"
  use "khaveesh/vim-fish-syntax"
  use "lukas-reineke/indent-blankline.nvim"
  use "raimon49/requirements.txt.vim"
  use "tpope/vim-fugitive"
  use "tpope/vim-unimpaired"
  use "vim-test/vim-test"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- See: https://github.com/wbthomason/packer.nvim#bootstrapping
  if packer_bootstrap then
    require('packer').sync()
  end
end)
