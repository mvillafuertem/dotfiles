vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showmatch = true
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {})
vim.keymap.set("n", "<leader>wq", ":wq<CR>", {})
vim.keymap.set("n", "<leader>q", ":q<CR>", {})
vim.keymap.set("n", "<leader>w", ":w<CR>", {})
-- vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- vim.keymap.set("n", "ª", ":m .+1<CR>==", { desc = "to move a line down" })
-- vim.keymap.set("i", "ª", ":m .+1<CR>==gi", { desc = "to move a line down" })
-- vim.keymap.set("n", "º", ":m .-2<CR>==", { desc = "to move a line up" })
-- vim.keymap.set("i", "º", ":m .-2<CR>==gi", { desc = "to move a line up" })

-- gv : go previous selection https://vimhelp.org/visual.txt.html#gv
-- gi : go back to your insert https://vimhelp.org/insert.txt.html#gi
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "" })

-- help map-modes
vim.keymap.set("x", "<leader>p", '"_dP', { desc = 'use register ["_] [d]elete and [P]aste' })
vim.keymap.set("x", "<leader>y", '"+y', { desc = 'use register ["+] and [y]ank' })
vim.keymap.set("n", "<leader>y", '"+y', { desc = 'use register ["+] and [y]ank' })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = 'use register ["+] and [Y]ank' })

vim.keymap.set("n", "<leader>d", '"_d', { desc = 'use register ["_] and [d]elete' })
vim.keymap.set("v", "<leader>d", '"_d', { desc = 'use register ["_] and [d]elete' })

vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", {})
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", {})
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", {})
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", {})

vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

vim.keymap.set("n", "n", "nzzzv", {})
vim.keymap.set("n", "N", "Nzzzv", {})

vim.keymap.set("n", "Q", "<nop>", {})

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {})

