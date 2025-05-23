-- vim.api.nvim_set_keymap('i', '<C-H>', '<C-w>', {noremap = true})

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
vim.keymap.set('n', '<leader>retb', '<cmd>%retab!<cr>') -- convert all leading spaces to tabs for the entire file

-- CTRL-Backspace to delete previous word
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', {noremap = true})

-- TODO: Create mapping to lookup vim keybindings in general, not just telescope ones (might just do this with rofi at the sxhkd level tbh)
vim.api.nvim_set_keymap('n', '<leader>kb', '<cmd>Telescope keymaps<cr>', {noremap = true}) -- show a list of keybinds

-- Remap visual block mode
vim.keymap.set("n", "<M-v>", "<C-v>", { noremap = true }) -- remap visual block mode to Alt+v

-- Move selected chunk up/down
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Half-page up/down with cursor always in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste over visually selected text without replacing clipboard contents with overwritten text
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-Q>", "<nop>") -- unbind Ctrl+Q from visual block mode so that QQ exits without saving

-- Map ctrl+s to save the file
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

-- Map qq to quit neovim
vim.keymap.set("n", "qq", "<Esc>:q<CR>")
-- Map QQ to force quit neovim without saving
vim.keymap.set("n", "QQ", "<Esc>:q!<CR>")

vim.keymap.set("v", "<C-c>", "y")
vim.keymap.set("n", "<C-v>", "p")

-- ToggleTerm open terminal in specific direction
vim.keymap.set("n", "<C-\\>h", ":ToggleTerm direction=horizontal size=15<CR>")
vim.keymap.set("n", "<C-\\>v", ":ToggleTerm direction=vertical size=80<CR>")
vim.keymap.set("n", "<C-\\>f", ":ToggleTerm direction=float<CR>")

-- Map <leader>src to :source a file easily
vim.keymap.set("n", "s", "<nop>") -- Need to remap s to <nop> so that it doesn't enter insert mode when pressed
vim.keymap.set("n", "<leader>src", ":source<CR>")

-- Yank entire file without moving cursor
vim.keymap.set("n", "<leader>yy", "<cmd>%y+<CR>") -- yank entire file into clipboard without moving cursor

vim.keymap.set("n", "<leader>aer", "<cmd>AerialToggle<CR>", { noremap = true, silent = true})

-- Toggle inline error messages while keeping signs
vim.keymap.set("n", "<leader>tim", function()
	local current_virtual_text = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current_virtual_text })
end, { noremap = true, silent = true })

-- Toggle floating window with warning/error messages for that line
-- vim.keymap.set("n", "<leader>df", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>df", function()
	local float_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			float_win = win
			break
		end
	end
	if float_win then
		vim.api.nvim_win_close(float_win, true)
	else
		vim.diagnostic.open_float()
	end
end, { noremap = true, silent = true })
