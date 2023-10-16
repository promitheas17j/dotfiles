-- local lsp = require('lsp-zero')

-- lsp.preset('recommended')
-- lsp.setup()

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gr', '<cmd>print "Hello"<cr>', {buffer = true})
  -- vim.key
end)

lsp.setup()
