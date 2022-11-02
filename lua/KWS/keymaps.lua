local opts = { noremap = true, silent = true }

local term_opts = {silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap SPACE as a leader key 
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Press ESC to set nohlsearch mode
keymap("n", "<esc>", ":nohlsearch <CR>", opts)

-- Plugin Keymaps Below

-- nvim-tree
keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)
