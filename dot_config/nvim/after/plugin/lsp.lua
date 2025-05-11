local cmp = require('cmp')
local lsp = require('lsp-zero').preset({})

-- local cmp_select = {behaviour = cmp.SelectBehaviour.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})

end)

lsp.configure('clangd', {
	cmd = { 'clangd', '--background-index', '--header-insertion=never' },
})

lsp.setup()

local border_opts = {
	border = "rounded",
	title = "hover"
}

local og_hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function(config)
	config = vim.tbl_deep_extend('force', {
		border = 'rounded',
		max_width = math.floor(vim.o.columns * 0.5),
		max_height = math.floor(vim.o.lines * 0.4),
	}, config or {})
	return og_hover(config)
end

require('lspconfig').pyright.setup{}

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})
