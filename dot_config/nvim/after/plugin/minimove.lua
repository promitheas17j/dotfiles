require('mini.move').setup({
	mappings = {
		left = 'H', -- while in visual mode move selection left
		right = 'L', -- while in visual mode move selection right
		down = 'J', -- while in visual mode move selection down
		up = 'K', -- while in visual mode move selection up
	}
})

vim.keymap.set('n', '<S-Left>', function () require('mini.move').move_line('left') end, { noremap = true, silent = true }) -- while in normal mode, move entire line under cursor left
vim.keymap.set('n', '<S-Right>', function () require('mini.move').move_line('right') end, { noremap = true, silent = true }) -- while in normal mode, move entire line under cursor right
vim.keymap.set('n', '<S-Down>', function () require('mini.move').move_line('down') end, { noremap = true, silent = true }) -- while in normal mode, move entire line under cursor down
vim.keymap.set('n', '<S-Up>', function () require('mini.move').move_line('up') end, { noremap = true, silent = true }) -- while in normal mode, move entire line under cursor up
