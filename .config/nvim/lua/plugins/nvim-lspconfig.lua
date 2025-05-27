return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }

      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

     -- if client.resolved_capabilities.document_formatting then
     --   vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
     -- end
    end

    lspconfig.lua_ls.setup {}
    lspconfig.nil_ls.setup {}
    lspconfig.ts_ls.setup {}
    lspconfig.jsonnet_ls.setup{
    	settings = {
    		ext_vars = {},
    		formatting = {
    			-- default values
    			Indent              = 2,
    			MaxBlankLines       = 2,
    			StringStyle         = 'single',
    			CommentStyle        = 'slash',
    			PrettyFieldNames    = true,
    			PadArrays           = false,
    			PadObjects          = true,
    			SortImports         = true,
    			UseImplicitPlus     = true,
    			StripEverything     = false,
    			StripComments       = false,
    			StripAllButComments = false,
    		},
    	},
    }

    local servers = { 'ts_ls', 'lua_ls', 'jsonnet_ls', 'nil_ls' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
      }
    end

  end
}
