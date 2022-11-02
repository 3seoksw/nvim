--vim.api.nvim_command([[
--	augroup ChangeBackgroundColour
--		autocmd Colorscheme * hi Normal guibg=NONE ctermbg=NONE
--		autocmd Colorscheme * hi clear LineNr
--	augroup END
--]])

vim.cmd ("syntax on")
local status, _ = pcall (vim.cmd, "colorscheme onedark")
if not status then
	print("Failed to load colourscheme")
 	return
end
