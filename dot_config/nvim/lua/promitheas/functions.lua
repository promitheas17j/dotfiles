local M = {}

function M.enter_visual_block()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("\\<C-v>", true, false, true), "n", true)
end

-- Open man page in new tab
function M.open_man()
	vim.ui.input({ prompt = "Man args: " }, function(input)
		if input and input ~= "" then
			vim.cmd("vert bo Man " .. input)
			local max_width = 80
			local min_width = 60
			local current_width = vim.api.nvim_win_get_width(0)
			-- vim.cmd("echo " .. current_width)
			if current_width > max_width then
				vim.cmd("vertical resize " .. max_width)
			elseif current_width < min_width then
					vim.cmd("vertical resize " .. min_width)
			end
		end
	end)
end

return M
