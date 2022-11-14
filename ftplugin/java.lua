local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end
capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local home = os.getenv "HOME"
WORKSPACE_PATH = home .. "/workspace/"

-- Find root of a project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "*.iml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

--local workspace_dir = home .. "/.local/share/eclipse" .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = WORKSPACE_PATH .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    --"-Declipse.application=org.eclipse.jdt.ls.core.id1",
    --"-Dosgi.bundles.defaultStartLevel=4",
    --"-Declipse.product=org.eclipse.jdt.ls.core.product",
    --"-Dlog.protocol=true",
    --"-Dlog.level=ALL",
    --"-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
    --"-Xms1g",
    --"--add-modules=ALL-SYSTEM",
    --"--add-opens",
    --"java.base/java.util=ALL-UNNAMED",
    --"--add-opens",
    --"java.base/java.lang=ALL-UNNAMED",

    -- 💀
    -- '-jar', '/Library/java/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    "-jar",
    --"~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
    vim.fn.glob("~/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    --vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

    -- 💀
    --'/Library/java/jdt-language-server-1.9.0-202203031534/config_mac/',
    --home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. "mac",
    "-configuration",
    "~/.local/share/nvim/mason/packages/jdtls/config_mac/",
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^

    -- 💀
    -- See `data directory configuration` section in the README
    "-data",
    workspace_dir,
    --vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir,
  },

  on_attach = require("KWS.plugins.lsp.handlers").on_attach,
  capabilities = capabilities,

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
    --root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.xml'}),
    --root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
  root_dir = root_dir,

  single_file_support = true,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
        -- settings = {
        --   profile = "asdf"
        -- }
      },
    },
    signatureHelp = { enabled = true },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.

jdtls.start_or_attach(config)
