return {
    cmd = { "rust-analyzer" },
    -- see https://rust-analyzer.github.io/book/configuration.html
    on_attach = function(client, bufnr)
        -- Note that the hints are only visible after rust-analyzer
        -- has finished loading and you have to edit the file
        -- to trigger a re-render.
        -- https://rust-analyzer.github.io/book/other_editors.html
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) -- Enable Rust inlay hints

        -- map keys to LSP defaults
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
    end,
    root_markers = { "Cargo.toml", ".git" },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "false" },
            check = { command = "clippy" },
            cargo = {
                allFeatures = true,
                buildScripts = false,
            },
            imports = { group = { enable = false } },
            completion = {
                postfix = { enable = false },
                fullFunctionSignatures = { enable = true },
            },
            -- diagnostics = { enable = true },
            rustfmt = { enable = true },
            semanticHighlighting = {
                -- do not highlight rust code in docstrings
                doc = { comment = { inject = { enable = false } } }
            }

        },

    },
    filetypes = { "rust" }
}
