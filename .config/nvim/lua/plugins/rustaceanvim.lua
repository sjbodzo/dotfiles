-- "batteries included" rust lsp config

return {
  'mrcjkb/rustaceanvim',
  dependencies = { "nvim-lua/plenary.nvim" },
  version = '^6', -- Recommended
  lazy = false,   -- This plugin is already lazy
  ft = { 'rust' },
  config = function()
    vim.g.rustaceanvim = {
      inlay_hints = {
        highlight = 'NonText',
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
        enable_nextest = false,
      },
      server = {
        -- on_attach = function(client, bufnr)
        -- Inlay hints
        --   require('lsp-inlayhints').on_attach(client, bufnr)
        --   -- Hover actions
        --   vim.keymap.set("n", "<C-space>", "<Cmd>RustLsp hover actions<CR>", { buffer = bufnr })

        --   local bufopts = { noremap = true, silent = true, buffer = bufnr }
        --   vim.keymap.set("n", "<leader>cR", "<Cmd>RustLsp codeAction<CR>", { desc = "Code Action", buffer = bufnr })

        --   -- default mappings
        --   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        --   vim.keymap.set('n', 'gd', "<Cmd>RustLsp relatedDiagnostics<CR>", bufopts)
        --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        --   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        --   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        --   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        --   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        --   vim.keymap.set('n', '<space>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --   end, bufopts)
        --   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        --   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        --   vim.keymap.set('n', '<space>ca', "<Cmd>RustLsp codeAction<CR>", bufopts)
        --   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        --   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        -- end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            -- keeps shell cargo and rust-analyzer cargo from compiling
            -- to the same place at the same time
            cargo = {
              targetDir = true,
              allFeatures = true,
              buildScripts = {
                enable = true,
              }
            },
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
            }
            -- Add clippy lints for Rust.
            --checkOnSave = {
            --  allFeatures = true,
            --  command = "clippy",
            --  extraArgs = { "--no-deps" },
            --},
          },
        },
      }
    }
  end
}
