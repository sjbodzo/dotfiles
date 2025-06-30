return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
    	'lua_ls',
    	'jsonnet_ls',
    	'nil_ls',
    	'gopls',
      'tilt_ls',
      'yamlls',
      'bashls',
      -- 'rust-analyzer' -- Disable when using rustaceanvim
    })

    local lspconfig = require("lspconfig")

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

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

    vim.lsp.config('yamlls', {
      cmd = { 'yaml-language-server', '--stdio' },
      filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
      single_file_support = true,
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          },
        }
      },
    })

    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_dir = require 'lspconfig.util'.root_pattern({
         '.luarc.json',
         '.luarc.jsonc',
         '.luacheckrc',
         '.stylua.toml',
         'stylua.toml',
         'selene.toml',
         'selene.yml',
         '.git',
      }),
      single_file_support = true,
      log_level = vim.lsp.protocol.MessageType.Warning,
    })

    vim.lsp.config('nil_ls', {
      cmd = { 'nil' },
      filetypes = { 'nix' },
      single_file_support = true,
      root_dir = require 'lspconfig.util'.root_pattern('flake.nix', '.git'),
      docs = {
        description = [[
          https://github.com/oxalica/nil

          A new language server for Nix Expression Language.

          If you are using Nix with Flakes support, run `nix profile install github:oxalica/nil` to install.
          Check the repository README for more information.

          _See an example config at https://github.com/oxalica/nil/blob/main/dev/nvim-lsp.nix._
              ]]
      },
    })

    vim.lsp.config('tilt_ls', {
      cmd = { 'tilt', 'lsp', 'start' },
      filetypes = { 'starlark', 'tiltfile' },
      root_markers = { 'Tiltfile' },
      docs = {
        description = [[
          https://docs.stack.build/docs/vscode/starlark-language-server
          ]],
      },
      single_file_support = true,
    })

    vim.lsp.config('jsonnet_ls', {
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
    })

    -- vim.lsp.config('gopls', {
    --   settings = {
    --     ['gopls'] = {},
    --   },
    -- })

    local servers = { 'lua_ls', 'jsonnet_ls', 'nil_ls', 'gopls', 'tilt_ls', 'bashls', 'yamlls' }
    for _, lsp in ipairs(servers) do
      vim.lsp.config[lsp].on_attach = on_attach
    end

  end
}
