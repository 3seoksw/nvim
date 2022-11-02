local options = {
	number = true,			-- enable line number
	relativenumber = true,	-- enable relative line number
	mouse = "a",			-- allow the mouse to be used
	cursorline = true,		-- highlight the current line
	smartcase = true,		-- allow searching capital letter included word
	smartindent = true, 	-- make indenting smarter
	tabstop = 4,			-- default tabstop 4 spaces
	shiftwidth = 4,
	softtabstop = 0,
	errorbells = true,
	incsearch = true,
	scrolloff = 8,
	termguicolors = true,	-- enable colours broadly
	hlsearch = true,		-- highlight text when searching
	clipboard = "unnamed",	-- allow clipboard copy by yanking
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

--vim.cmd ("set clipboard=unnamed")
vim.cmd ("set whichwrap+=<,>,[,],h,l")
vim.cmd ("set iskeyword+=-")
vim.cmd ("set formatoptions-=cro") -- TODO: this doesn't seem to work
