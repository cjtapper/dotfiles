vim.g.mapleader = "\\"

-- Open netrw
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex)

-- Sanely handle line navigation for long lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<Down>", "g<Down>")
vim.keymap.set("n", "<Up>", "g<Up>")

-- Copying/pasting text to the system clipboard.
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>y", [[VV"+y]])
vim.keymap.set("n", "<leader>Y", [["+y]])

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Prevent entering the Ex blackhole
vim.keymap.set("n", "Q", "<nop>")
