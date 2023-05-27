local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
  ensure_installed = {
    "rust_analyzer",
    "tsserver",
    "marksman",
    "rnix",
    "sqlls",
    "yamlls",
    "gopls",
    "bashls",
    "lua_ls"
  }
}

