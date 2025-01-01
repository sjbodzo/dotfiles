-- neovim lsp shim for plugins to augment lsp
return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    local null_ls = require('null-ls')
    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end
        end,
        sources = {
          formatting.black.with({
            extra_args = { "--line-length", "80" },
            prefer_local = ".venv/bin",
          }),
          diagnostics.mypy.with({
            extra_args = { "--ignore-missing-imports" },
            prefer_local = ".venv/bin",
          }),
        }
    })

    --null_ls.setup{
    --    sources = {
          --diagnostics.flake8.with({
          --  extra_args = { "--max-line-length", "88", "--max-complexity", "18", "--select", "B,C,E,F,W,T4,B9", "--ignore", "E266,E501,E402" }
          --}),
          --formatting.black.with({
          --  extra_args = { "--line-length", "160" }
          --}),
          --formatting.isort,
          ----.with({
          ----  args = { "--stdout", "--filename", "$FILENAME", "-" }
          ----}),
          --formatting.stylua,
          --formatting.autoflake,
          --formatting.isort.with({
          --  args = { "--profile", "black", "--filter-files"}
          --}),
          --diagnostics.mypy.with({
          --  extra_args = { "--ignore-missing-imports" },
          --  --prefer_local = ".venv/lib/python3.11/site-packages/mypy",
          --}),
          --diagnostics.pydocstyle,
          --diagnostics.eslint_d,
          --code_actions.eslint_d,
          --formatting.prettierd,
    --    }
    --}
  end,
  after = { "nvim-lspconfig" }
}
