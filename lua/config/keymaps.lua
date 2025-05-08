-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- aDD ANY ADDITIONAL KEYMAPS HERE

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--increment/decrement

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

--undo and redo
keymap.set("n", "zz", ":redo<cr>", opts)

--navigate between tabs
keymap.set("n", "<S-l>", ":BufferLineCycleNext<cr>", opts)
keymap.set("n", "<S-h>", ":BufferLineCyclePrev<cr>", opts)

--delete a word backwards
keymap.set("n", "dw", 'vb"_d')

--select all
keymap.set("n", "<C-a>", "gg<S-v>G")

--handle tabs
--create new tab
keymap.set("n", "te", ":tabedit<cr>", opts)
--remove current active tab
keymap.set("n", "tr", ":bd<cr>", opts)

--handle windows
--split window below/vertically
keymap.set("n", "sd", ":split<cr>", opts)
keymap.set("n", "sn", ":vsplit<cr>", opts)
--navigate between windows
keymap.set("n", "sh", "<c-w>h")
keymap.set("n", "sl", "<c-w>l")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "ww", "<C-w>w")

--resize windows
keymap.set("n", "<C-w>right", "<C-w>>")
keymap.set("n", "<C-w>up", "<C-w>+")
keymap.set("n", "<C-w>left", "<C-w><")
keymap.set("n", "<C-w>down", "<C-w>-")

--diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)
keymap.set("n", "<C-k>", function()
  vim.diagnostic.goto_prev()
end)

--save
keymap.set("n", "<space>w", ":w<cr>", opts)

--file exlplorer
keymap.set("n", "<space>e", ":NvimTreeToggle<cr>", opts)
--terminal
keymap.set("n", "<space>th", ":split<cr>|:term<cr>|:startinsert<cr>", opts)
