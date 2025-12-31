-- lua/core/keymaps.lua
vim.g.mapleader = " "

local map = vim.keymap.set

-- quit forcibly
map("n", "qq", ":q!<CR>")
-- save and quit 
map("n", "<leader>q", ":wq<CR>")
map("n", "<leader>w", ":w<CR>")

map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

map("n", "<leader>e", ":NvimTreeToggle<CR>")
