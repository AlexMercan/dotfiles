--[[vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv]]
--

local opts = { silent = true, noremap = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader><CR>", ":luafile ~/.config/nvim/init.lua<CR>", opts)
keymap("n", ";", ":", { noremap = true })
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

keymap("n", "]a", ":cnext<CR>zz", opts)
keymap("n", "[a", ":cprev<CR>zz", opts)

keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)

keymap("i", "<A-h>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<A-j>", "<C-\\><C-N><C-w>j", opts)
keymap("i", "<A-k>", "<C-\\><C-N><C-w>k", opts)
keymap("i", "<A-l>", "<C-\\><C-N><C-w>l", opts)

keymap("i", "<C-c>", "<C-[>", opts)
keymap("v", "<C-c>", "<C-[>", opts)

keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", "<C-q>", ":lua require('config.functions').toggle_qf()<CR>", opts)
