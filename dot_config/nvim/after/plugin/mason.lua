require('mason').setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"pyright",
		"lua_ls",
		"bashls",
		"jsonls",
		"html",
		"cssls",
		"vimls",
		"awk_ls",
		"rust_analyzer",
		"clangd"
	},
	automatic_installation = true,
	automatic_enable = {
		exclude = {
			"clangd",
			"pyright",
		}
	}
}

require('lsp-zero').skip_server_setup({"clangd"})
