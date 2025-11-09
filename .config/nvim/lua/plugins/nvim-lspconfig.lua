return {
  "neovim/nvim-lspconfig",
  config = function()
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
    end

    -- Configure each language server
    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_dir = require('lspconfig.util').root_pattern({
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
      on_attach = on_attach,
    })

    vim.lsp.config('nil_ls', {
      cmd = { 'nil' },
      filetypes = { 'nix' },
      single_file_support = true,
      root_dir = require('lspconfig.util').root_pattern('flake.nix', '.git'),
      on_attach = on_attach,
    })

    vim.lsp.config('gopls', {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_dir = require('lspconfig.util').root_pattern('go.work', 'go.mod', '.git'),
      single_file_support = true,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
      on_attach = on_attach,
    })

    vim.lsp.config('tilt_ls', {
      cmd = { 'tilt', 'lsp', 'start' },
      filetypes = { 'starlark', 'tiltfile' },
      root_dir = require('lspconfig.util').root_pattern('Tiltfile'),
      single_file_support = true,
      on_attach = on_attach,
    })

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
      on_attach = on_attach,
    })

    vim.lsp.config('bashls', {
      cmd = { 'bash-language-server', 'start' },
      filetypes = { 'sh', 'bash' },
      root_dir = require('lspconfig.util').root_pattern('.git'),
      single_file_support = true,
      on_attach = on_attach,
    })

    vim.lsp.config('helm_ls', {
      cmd = { 'helm_ls', 'serve' },
      filetypes = { 'helm' },
      root_dir = require('lspconfig.util').root_pattern('Chart.yaml'),
      single_file_support = true,
      settings = {
        ['helm-ls'] = {
          logLevel = "info",
          valuesFiles = {
            mainValuesFile = "values.yaml",
            lintOverlayValuesFile = "values.lint.yaml",
            additionalValuesFilesGlobPattern = "*values*.yaml"
          },
          yamlls = {
            enabled = true,
            enabledForFilesGlob = "*.{yaml,yml}",
            diagnosticsLimit = 50,
            showDiagnosticsDirectly = false,
            path = "yaml-language-server",
            config = {
              schemas = {
                kubernetes = "templates/**",
              },
              completion = true,
              hover = true,
            }
          }
        }
      },
      on_attach = on_attach,
    })

    -- Enable all configured language servers
    vim.lsp.enable({
      'lua_ls',
      'nil_ls',
      'gopls',
      'tilt_ls',
      'yamlls',
      'bashls',
      'helm_ls',
    })
  end
}
