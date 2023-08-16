local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

local cmp = require('cmp')

cmp.setup({
sources = {
		{name = 'nvim_lsp'},
		{name = 'buffer'},
		{name = 'cmp-path'},
		{name = 'cmp-luasnip'},
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		-- ['<Tab>'] = cmp_action.tab_complete(),
		-- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
	    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),	
	},
})
