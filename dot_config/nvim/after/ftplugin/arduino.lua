vim.cmd([[ autocmd BufRead,BufNewFile *.ino set filetype=cpp ]])
vim.opt_local.formatoptions:remove({ 'r', 'o' })
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
