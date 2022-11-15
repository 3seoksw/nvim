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
	"texlab",	    -- LaTeX
}

mason.setup()
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("KWS.plugins.lsp.handlers").on_attach,
		capabilities = require("KWS.plugins.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	if server == "clandg" then
		local clangd_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end
	
	if server == "html" then
		local html_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", html_opts, opts)
	end
	
	if server == "cssls" then
		local cssls_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", cssls_opts, opts)
	end
	
	if server == tailwindcss then
		local tailwindcss_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
	end
	
	if server == "sumneko_lua" then
		local sumneko_lua_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", sumneko_lua_opts, opts)
	end
	
	if server == "texlab" then
		local texlab_opts = require("kws.plugins.lsp.handlers")
		opts = vim.tbl_deep_extend("force", texlab_opts, opts)
	end
	
	if server == "jdtls" then
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
