--astrotheme This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer can manage itself
	use('wbthomason/packer.nvim')

	-- Theme
	use('Mofiqul/dracula.nvim')
	
	use
	{
		'nvim-telescope/telescope.nvim', -- tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = {
			{'nvim-lua/plenary.nvim'}
		}
	}
	use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})

	use {'saadparwaiz1/cmp_luasnip'}

	-- LSP support
	use
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},		-- Required
			{'hrsh7th/cmp-buffer'},		-- Completes words from current buffer
			{'hrsh7th/cmp-path'},		-- Completes files
			{'hrsh7th/cmp-nvim-lua'},	-- Completes nvim lua
			{'hrsh7th/cmp-nvim-lsp'},	-- Required
			{'L3MON4D3/LuaSnip'},		-- Required
		}
	}
	use('tpope/vim-fugitive')

	-- Highlight and search through certain keywords in comments
	use
	{
		'folke/todo-comments.nvim',
		requires = {'nvim-lua/plenary.nvim'},
	}
	use('nvim-tree/nvim-tree.lua')

	-- Status bar on bottom of active buffer
	use
	{
		'nvim-lualine/lualine.nvim',
		requires = {
			'nvim-tree/nvim-web-devicons',
			opt = true
		}
	}

	use('ThePrimeagen/vim-be-good')

	-- Autocomplete brackets
	-- use('m4xshen/autoclose.nvim')
	-- use('windwp/nvim-autopairs')
	use("windwp/nvim-autopairs")

	-- Nerdtree (nvim file manager)
	use('scrooloose/nerdtree')
	use('tiagofumo/vim-nerdtree-syntax-highlight')
	use('ryanoasis/vim-devicons')

	-- Jumping between marked files easily
	use('theprimeagen/harpoon')

	-- Displaying tabs
	use('lukas-reineke/indent-blankline.nvim')
	
	-- Commenting
	use('tpope/vim-commentary')

	-- Make sure next part is last, after any plugins
	if packer_bootstrap then
		 require('packer').sync()
	end
end)
