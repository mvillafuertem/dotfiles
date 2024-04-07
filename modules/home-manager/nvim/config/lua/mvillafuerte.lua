vim.g.mapleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {})
vim.keymap.set("n", "<leader>wq", ":wq<CR>", {})
vim.keymap.set("n", "<leader>q", ":q<CR>", {})
vim.keymap.set("n", "<leader>w", ":w<CR>", {})
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.keymap.set("n", "ª", ":m .+1<CR>==", { desc = "to move a line down" })
vim.keymap.set("i", "ª", ":m .+1<CR>==gi", { desc = "to move a line down" })
        vim.keymap.set("n", "º", ":m .-2<CR>==", { desc = "to move a line up" })
        vim.keymap.set("i", "º", ":m .-2<CR>==gi", { desc = "to move a line up" })
-- gv : go previous selection https://vimhelp.org/visual.txt.html#gv
-- gi : go back to your insert https://vimhelp.org/insert.txt.html#gi
vim.keymap.set("v", "ª", ":m '>+1<CR>gv==gv", { desc = "" })
vim.keymap.set("v", "º", ":m '<-2<CR>gv==gv", { desc = "" })

