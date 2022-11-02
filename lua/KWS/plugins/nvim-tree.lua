local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("set splitright")
vim.cmd("set splitright")

vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

nvimtree.setup({
    view = {
      mappings = {
        list = {
          -- open a file with vertical split by "s"
          { key = "s", action = "vsplit" },

          -- open a file with horizontal split by "u"
          { key = "u", action = "split" },
        }
      }
    },
    -- change folder arrow icons
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
  })
