--astrotheme This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- use "AstroNvim/astrotheme"
  use {
	    "AstroNvim/astrotheme",
	     config = function() 
     		require("astrotheme").setup()
     	end,
  }

  --[[
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  vim.cmd [[colorscheme nightfly ]]
  --]]

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})

end)
