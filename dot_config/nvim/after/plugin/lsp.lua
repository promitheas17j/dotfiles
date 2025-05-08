-- local lsp = require('lsp-zero')

-- lsp.preset('recommended')
-- lsp.setup()

local cmp = require('cmp')
local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

-- local cmp_select = {behaviour = cmp.SelectBehaviour.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})

end)

-- lsp.configure('clangd', {
--	 cmd = { 'clangd', '--header-insertion=never' }
-- })

lspconfig.clangd.setup({
	cmd = { 'clangd', '--header-insertion=never' },
	on_attach = lsp.build_options('clangd').on_attach
})

lsp.setup()
