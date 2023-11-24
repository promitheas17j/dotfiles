local autocmd_group = vim.api.nvim_create_augroup(
	"Custom auto-commands",
	{clear = true}
)

vim.api.nvim_create_autocmd(
	{"BufWritePost"},
	{
		pattern = {"*.tex"},
		desc = "Auto-compile latex files after saving",
		callback = function()
			local file_name = vim.api.nvim_buf_get_name(0) -- Get file name
			vim.cmd(":!pdflatex " .. file_name)
		end,
		group = autocmd_group,
	}
)

--[[
vim.api.nvim_create_autocmd(
	{"BufEnter"},
	{
		desc = "Change whitespace colour for space character",
		callback = function()
			vim.api.nvim_command("hi Whitespace guifg=#00ff00")
		end,
		group = autocmd_group,
	}
)
--]]

vim.api.nvim_create_autocmd(
	"ColorScheme", {
		desc = "Change whitespace colour for space character",
		pattern = "dracula", -- change this to whatever the name of the colorscheme is
		command = "hi Whitespace guifg=#aaaaaa",
		group = autocmd_group,
})
