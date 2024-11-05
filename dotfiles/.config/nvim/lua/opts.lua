local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.opt.termguicolors = true

vim.opt.guicursor = ""
vim.opt.showmode = false

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

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", nbsp = "~", extends = ">", precedes = "<" }

vim.opt.autoread = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/vim/undo"
vim.opt.undofile = true
vim.opt.undoreload = 10000

vim.opt.textwidth = 80
vim.opt.formatoptions = { "c", "q" }

vim.opt.updatetime = 500 -- For CursorHold events

-- Trailing whitespace listchars. Hide in insert mode
local trailingWhitespaceListchars = vim.api.nvim_create_augroup(
  'trailingWhitespaceListchars', { clear = true }
)
autocmd("InsertEnter", {
  command = "set listchars-=trail:·",
  group = trailingWhitespaceListchars,
})
autocmd("InsertLeave", {
  command = "set listchars+=trail:·",
  group = trailingWhitespaceListchars,
})

-- Return to the same line when you reopen a file
local lineReturn = vim.api.nvim_create_augroup(
  'lineReturn', { clear = true }
)
autocmd(
  "BufReadPost",
  {
    callback = function()
      local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
      if { row, col } ~= { 0, 0 } then
        vim.api.nvim_win_set_cursor(0, { row, 0 })
      end
    end,
    group = lineReturn
  }
)

-- Hightlight yanked text
local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

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
