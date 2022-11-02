source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/coc.vim

luafile $HOME/.config/nvim/lua/treesitter.lua
"luafile $HOME/.config/nvim/lua/vimspector.lua

colorscheme onehalfdark
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

hi Normal guibg=NONE ctermbg=NONE
highlight clear LineNr

let g:markdown_fenced_languages = ['c++', 'html', 'python', 'lua', 'vim', 'typescript', 'javascript']
let g:markdown_syntax_conceal = 0
let g:airline#extensions#tabline#enabled = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']

let g:vimspector_base_dir='/Users/kws/.config/nvim/autoload/plugged/vimspector'

syntax on
set t_Co=256
set number
set relativenumber
set mouse=a
set cursorline
set smartindent
set tabstop=4
set softtabstop=0 
set shiftwidth=4
set errorbells
set incsearch
set scrolloff=8
set termguicolors
set nohlsearch
set splitright
