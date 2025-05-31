require('core.lazy')
require('core.keymaps')
require('core.options')
require('core.autocmds')
require('core.lsp_diagnostic')

-- Disable when using rustaceanvim
-- vim.lsp.enable({
--   "rust-analyzer"
-- })

vim.lsp.enable('gopls')
