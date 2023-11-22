local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

local cmp = require('cmp')
local lsp = require('lsp-zero').preset({})

cmp.setup({
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'buffer', keyword_length = 5},
		{name = 'path'},
		{name = 'luasnip'},
		{name = 'nvim_lua'},
	}),
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({select = true}),
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-Space>'] = cmp.mapping.complete(),

	},
	snippet = {
		expand = function(args)
			local luasnip = require("luasnip")
			if not luasnip then
				return
			end
			luasnip.lsp_expand(args.body)
		end,
	},
	experimental = {
		ghost_text = true,
	}

})
