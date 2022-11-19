local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("set splitright")
--vim.cmd("set splitdown")

--vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

nvimtree.setup({
    view = {
      mappings = {
        list = {
          { key = "s", action = "vsplit" },
          { key = "u", action = "hsplit" },
        },
      },
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
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
  })
