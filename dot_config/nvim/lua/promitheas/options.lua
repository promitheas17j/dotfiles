termguicolors = true
vim.keymap.set('n', '<leader>hs', '<cmd>sp<CR>') -- create horizontal split (of current buffer)
vim.keymap.set('n', '<leader>vs', '<cmd>vs<CR>') -- create vertical split (of current buffer)
vim.keymap.set('n', '<leader>n', '<cmd>new<CR>') -- create horizontal split (new file)
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>') -- quit current window
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<CR>') -- move cursor to bottom window
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<CR>') -- move cursor to top window
vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<CR>') -- move cursor to left window
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<CR>') -- move cursor to right window
-- TODO: Add keybinds for moving windows around: https://neovim.io/doc/user/windows.html#window-moving
-- TODO: Lookup keybinds for accepting autocomplete suggestions
