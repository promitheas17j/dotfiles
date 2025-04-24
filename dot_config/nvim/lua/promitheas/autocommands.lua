local autocmd_group = vim.api.nvim_create_augroup(
	"Custom auto-commands",
	{clear = true}
)

vim.api.nvim_create_autocmd(
	{"BufWritePost"},
	{
		pattern = {"*.md"},
		desc = "Auto-compile markdown files to pdf after saving",
		callback = function()
			local file_name = vim.api.nvim_buf_get_name(0) -- Get file name
			local first_line = vim.fn.readfile(file_name, '', 1)[1]

			if first_line == "<!-- NO_PDF -->" then
				return -- skip PDF compilation if the fist line is <!-- NO_PDF -->
			end

			local new_file_name = file_name:gsub("%.[^%.]+$", ".pdf")
			vim.cmd(":!pandoc -f markdown-implicit_figures " .. file_name .. " -o " .. new_file_name)
		end,
		group = autocmd_group,
	}
)

vim.api.nvim_create_autocmd(
	{"BufWritePost"},
	{
		pattern = {"*.tex"},
		desc = "Auto-compile latex files after saving",
		callback = function()
			local file_name = vim.api.nvim_buf_get_name(0) -- Get file name
			vim.cmd(":!pdflatex " .. file_name)
			vim.cmd(":!bibtex " .. file_name)
			vim.cmd(":!pdflatex " .. file_name)
			vim.cmd(":!pdflatex " .. file_name)
		end,
		group = autocmd_group,
	}
)

vim.api.nvim_create_autocmd(
	"ColorScheme", {
		desc = "Change whitespace colour for space character",
		pattern = "dracula", -- change this to whatever the name of the colorscheme is
		command = "hi Whitespace guifg=#aaaaaa",
		group = autocmd_group,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Remove behaviour of autocommenting a newline if the previous line is a comment",
	callback = function()
		vim.opt_local.formatoptions:remove("o", "r", "c")
	end,
	group = autocmd_group,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = autocmd_group,
})
