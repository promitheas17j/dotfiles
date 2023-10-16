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
	use 'wbthomason/packer.nvim'
	--[[ use
	{
		"AstroNvim/astrotheme",
			config = function()
				require("astrotheme").setup()
			end,
	} --]]
	--[[ use
	{
		'Mofiqul/dracula.nvim',
		config = function()
			require('lualine').setup()
			{
				options = {
					theme = 'dracula-soft'
				}
			}
		end,
	} ]]--
	use
	{
		'Mofiqul/dracula.nvim',
		config = function()
			require('lualine').setup()
			{
				options = {
					theme = 'dracula-soft'
				}
			}
			vim.cmd("luafile $HOME/.config/nvim/lua/promitheas/dracula.lua")
		end,
	}
	use
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = {
			{'nvim-lua/plenary.nvim'}
		}
	}
	use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})
	use
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}
	use('tpope/vim-fugitive')
	use
	{
		'folke/todo-comments.nvim',
		requires = {'nvim-lua/plenary.nvim'},
	}
	use
	{
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
			opts = true
		}
	}
	use 'ThePrimeagen/vim-be-good'
	use 'm4xshen/autoclose.nvim'

	if packer_bootstrap then
		 require('packer').sync()
	end
end)
