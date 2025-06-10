vim.opt.termguicolors = true

vim.opt.guicursor = ""
vim.opt.showmode = false -- We show the mode in lualine - no need to double up

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.autoread = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.textwidth = 80
vim.opt.formatoptions = { "c", "q" }

vim.opt.updatetime = 500 -- For CursorHold events

vim.opt.laststatus = 2
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.colorcolumn = { 80 }

vim.opt.scrolloff = 10

-- Incremental search with highlighting
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.signcolumn = "yes"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.python3_host_prog = "/home/cjtapper/.local/share/nvim/venv/bin/python"

vim.filetype.add({
  pattern = {
    ["%.envrc"] = 'sh',
  },
})
