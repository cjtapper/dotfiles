local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Return to the same line when you reopen a file
local lineReturn = augroup('lineReturn', { clear = true })
autocmd(
  "BufReadPost",
  {
    callback = function()
      local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
      local line_count = vim.api.nvim_buf_line_count(0)
      row = math.max(0, math.min(row, line_count))
      pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
    end,
    group = lineReturn
  }
)

-- Highlight yanked text
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

-- Check for file changes when returning to nvim (e.g. after Ctrl-Z)
autocmd({ "FocusGained", "BufEnter", "VimResume" }, {
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Highlight cursorline only in the active window
local cursorLine = augroup("CursorLine", { clear = true })
autocmd({ "WinEnter", "BufEnter" }, {
  group = cursorLine,
  callback = function()
    vim.wo.cursorline = true
  end,
})
autocmd("WinLeave", {
  group = cursorLine,
  callback = function()
    vim.wo.cursorline = false
  end,
})
