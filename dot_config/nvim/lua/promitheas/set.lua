vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.wrap = true

vim.opt.hlsearch = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.formatoptions:remove({'c', 'r', 'o' })

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.list = true
vim.opt.listchars:append("space:·")
vim.opt.listchars:remove("trail")
vim.opt.listchars:append("tab:| ")
