vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.NERDTreeToggle)

vim.keymap.set("n", "<leader>c", "<cmd>let @/ = \"\"<CR>") -- clear search highlighting

-- NVim window (splits) keybinds
vim.keymap.set('n', '<leader>hs', '<cmd>sp<CR>') -- create horizontal split (of current buffer)
vim.keymap.set('n', '<leader>vs', '<cmd>vs<CR>') -- create vertical split (of current buffer)
vim.keymap.set('n', '<leader>n', '<cmd>new<CR>') -- create horizontal split (new file)
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>') -- quit current window
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<CR>') -- move cursor to bottom window
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<CR>') -- move cursor to top window
vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<CR>') -- move cursor to left window
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<CR>') -- move cursor to right window
vim.keymap.set('n', '<leader>K', '<cmd>wincmd K<CR>') -- move current window to top position
vim.keymap.set('n', '<leader>J', '<cmd>wincmd J<CR>') -- move current window to bottom position
vim.keymap.set('n', '<leader>H', '<cmd>wincmd H<CR>') -- move current window to left position
vim.keymap.set('n', '<leader>L', '<cmd>wincmd L<CR>') -- move current window to right position

-- vim.keymap.set('n', '<C-BS>', 'db') -- CTRL-Backspace to delete previous word
-- TODO: Lookup keybinds for accepting autocomplete suggestions
-- vim.keymap.set("i", " 

-- TODO: Create mapping to lookup vim keybindings in general, not just telescope ones
vim.api.nvim_set_keymap('n', '<leader>kb', '<cmd>Telescope keymaps<cr>', {noremap = true}) -- show a list of keybinds

vim.api.nvim_set_keymap('i', '<C-H>', '<C-w>', {noremap = true})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "Q", "<nop>")
