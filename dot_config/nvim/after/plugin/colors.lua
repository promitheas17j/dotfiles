function ColorMyPencils(color)
	color = 'dracula'
	-- color = color or "astrodark"
	--color = color or "nightfly"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#bd93f9" })
end

ColorMyPencils()
