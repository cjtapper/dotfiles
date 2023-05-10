vim.g.mapleader = "\\"

-- Open netrw
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex)

-- Sanely handle line navigation for long lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Better switching between windows.
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Copying/pasting text to the system clipboard.
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>y", [[VV"+y]])
vim.keymap.set("n", "<leader>Y", [["+y]])

-- Move visually selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Prevent entering the Ex blackhole
vim.keymap.set("n", "Q", "<nop>")
