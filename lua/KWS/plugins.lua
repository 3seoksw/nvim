local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
	-- Fundamentals
  	use ("wbthomason/packer.nvim") 	-- Have packer manage itself

	-- Themes
    use ("joshdick/onedark.vim")
    use ("nvim-lualine/lualine.nvim")
	use ({"nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
      })
	use ("sheerun/vim-polyglot")              -- Language Packs
    use ("nvim-tree/nvim-web-devicons")

	-- File Explorer
  	use ("nvim-lua/plenary.nvim")
    use ("nvim-tree/nvim-tree.lua")

	-- Syntax 
    use ("jiangmiao/auto-pairs")

    -- Completions
    use ("hrsh7th/nvim-cmp")
    use ("hrsh7th/cmp-buffer")
    use ("hrsh7th/cmp-path")
    
    -- Snippets
    use ("L3MON4D3/LuaSnip")
    use ("saadparwaiz1/cmp_luasnip")
    use ("rafamadriz/friendly-snippets")

    -- LSP related
    use ("williamboman/mason.nvim")             -- lsp manager
    use ("williamboman/mason-lspconfig.nvim")   -- configuration 
    use ("neovim/nvim-lspconfig")               -- configure lsp servers 
    use ("hrsh7th/cmp-nvim-lsp")                -- configure lsp servers appearing auto completions
    use ({ "glepnir/lspsaga.nvim", branch = "main" })
    use ("onsails/lspkind.nvim")

    -- Uncategorized
  	use "nvim-lua/popup.nvim" 	
	use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
