local setup, syntastics = pcall(require, "synatastics")
if not setup then
  return
end

vim.cmd("set statusline+=%#warningmsg#")
vim.cmd("set statusline+=%{SyntasticStatuslineFlag()}")
vim.cmd("set statusline+=%*")

vim.cmd [[
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_python_checkers = ['pylint']
]]
