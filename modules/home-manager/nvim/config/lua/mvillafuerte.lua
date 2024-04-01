vim.g.mapleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {})
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
