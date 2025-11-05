vim.g.mapleader = "\\"

-- Open netrw
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex)

-- Sanely handle line navigation for long lines
vim.keymap.set("n", "<Down>", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
vim.keymap.set("n", "<Up>", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })

-- Copying/pasting text to the system clipboard.
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>y", [[VV"+y]])
vim.keymap.set("n", "<leader>Y", [["+y]])

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Prevent entering the Ex blackhole
vim.keymap.set("n", "Q", "<nop>")
