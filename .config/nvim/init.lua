-- Change leader to a comma before init of lazy to ensure
-- that any mappings set here use the correct <leader> and
-- not the default <leader> of '\'
require("helpers.keys").set_leader(",")

require('core.lazy')
require('core.keymaps')
require('core.options')
require('core.autocmds')
require('core.filetype')
require('core.lsp_diagnostic')
require('core.treesitter')
