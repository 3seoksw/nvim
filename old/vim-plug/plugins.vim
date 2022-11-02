call plug#begin('~/.config/nvim/autoload/plugged')

	" Themes	
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'nvim-treesitter/nvim-treesitter'

	" File Explorer
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
	Plug 'nvim-tree/nvim-tree.lua'

	" Language Packs
	Plug 'sheerun/vim-polyglot'

	" Syntax & LSP etc.
	Plug 'jiangmiao/auto-pairs'
	Plug 'vim-syntastic/syntastic'
	Plug 'puremourning/vimspector'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Markdown
	Plug 'tpope/vim-markdown'
	Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }

call plug#end()
