vim.api.nvim_set_option_value("shiftwidth", 4, { scope = "local" })
vim.api.nvim_set_option_value("softtabstop", 4, { scope = "local" })
vim.api.nvim_set_option_value("shiftwidth", 4, { scope = "local" })
vim.api.nvim_set_option_value("colorcolumn", "72,80,88", { scope = "local" }) -- comment,pep8,black
vim.api.nvim_set_option_value("textwidth", 72, { scope = "local" })
vim.api.nvim_set_option_value("formatoptions", "c,q", { scope = "local" })

local gen_hook = require("mini.splitjoin").gen_hook
local brackets = { brackets = { '%b{}', '%b()', '%b[]' } }

-- Add trailing comma when splitting inside brackets
local add_comma = gen_hook.add_trailing_separator(brackets)

-- Delete trailing comma when joining inside brackets
local del_comma = gen_hook.del_trailing_separator(brackets)

-- Create buffer-local config
vim.b.minisplitjoin_config = {
  split = { hooks_post = { add_comma } },
  join  = { hooks_post = { del_comma } },
}
