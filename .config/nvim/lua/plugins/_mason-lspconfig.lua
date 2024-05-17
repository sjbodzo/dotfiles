local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

local langs = {
    "rust_analyzer",
    "tsserver",
    "marksman",
    "rnix",
    -- "sqlls",
    "yamlls",
    "gopls",
    "bashls",
    "lua_ls",
    "jsonnet_ls"
}

local handlers = {
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
          Lua = {
              diagnostics = {
                  globals = { "vim" }
              }
          }
      }
    }
  end,
}

mason_lspconfig.setup {
  ensure_installed = langs,
  automatic_installation = true,
}
mason_lspconfig.setup_handlers(handlers)
