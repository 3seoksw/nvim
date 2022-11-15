local M = {}

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("KWS.plugins.lsp.mason")
require("KWS.plugins.lsp.handlers").setup()
require("KWS.plugins.lsp.lspsaga")
