require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim"},
})

-- local handlers = require('nvim-autopairs.completion.handlers')
-- local cmp = require('nvim-autopairs.completion.cmp')

-- cmp.event:on(
--	'confirm_done',
--	cmp_autopairs.on_confirm_done({
--		filetypes = {
--			["*"] = {
--				["("] = {
--					kind = {
--						cmp.lsp.CompletionItemKind.Function,
--						cmp.lsp.CompletionItemKind.Method,
--					},
--					handler = handlers["*"]
--				}
--			},
--			lua = {
--				["("] = {
--					kind = {
--						cmp.lsp.CompletionItemKind.Function,
--						cmp.lsp.CompletionItemKind.Method,
--					},
--					handler = function(char, item, bufnr, rules, commit_character)
--					end
--				}
--			},

--			tex = false
--		}
--	})
-- )
