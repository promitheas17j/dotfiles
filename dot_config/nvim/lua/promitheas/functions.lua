local M = {}

function enter_visual_block()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("\\<C-v>", true, false, true), "n", true)
end

return M
-- return {enter_visual_block = enter_visual_block}
