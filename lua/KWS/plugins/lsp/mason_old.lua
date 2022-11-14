-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local servers = {
    "clangd",       -- C, C++
	"jdtls",		-- Java
	"pyright",   	-- Python
	"sumneko_lua",
	"texlab",			-- LaTeX
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
	ensure_installed = servers,
	automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
	  on_attach = require("KWS.plugins.lsp.handlers").on_attach,
	  capabilities = require("KWS.plugins.lsp.handlers").capabilites,
	}

	server = vim.split(server, "@")[1]

    if server == "clangd" then
      lspconfig["clangd"].setup(opts)
    end

    if server == "pyright" then
      lspconfig.pyright.setup(opts)
	  goto continue
      --local pyright_opts = require "KWS.plugins.lsp.settings.pyright"
      --opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end
    
	if server == "sumneko_lua" then
      lspconfig.sumneko_lua.setup({
        opts,
        "KWS.plugins.lsp.settings.sumneko_lua",
      })
   	  goto continue
  	end

	if server == "jdtls" then
      lspconfig.jdtls.setup(opts)
	  goto continue
	end

    if server == "texlab" then
      lspconfig["texlab"].setup({
          opts,
          "KWS.plugin.lsp.settings.texlab"
        })
      goto continue
    end

	lspconfig[server].setup(opts)
	::continue::
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end
