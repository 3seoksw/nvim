local M = {}

local nvim_snippets_path = "lua/KWS/plugins/luasnip/"
local luasnip_snippets_path = "lua/KWS/plugins/luasnip/"
local nvim_snippets_modules = "snippets."
local luasnip_snippets_modules = "luasnip_snippets.snippets."

function M.load_snippets()
    print("load luasnip_snippets")

    local t = {}

    local nvim_snippets = vim.api.nvim_get_runtime_file( nvim_snippets_path .. "*.lua", true)
    local luasnip_snippets = vim.api.nvim_get_runtime_file( luasnip_snippets_path .. "*.lua", true)

    t = insert_snippets_into_table(t, nvim_snippets_modules, nvim_snippets)
    t = insert_snippets_into_table(t, luasnip_snippets_modules, luasnip_snippets)

    return t
end
