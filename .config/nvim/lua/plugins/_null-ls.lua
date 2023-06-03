local null_ls = require('null-ls')
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup{
    debug=true,
    sources = {
      diagnostics.flake8.with({
        extra_args = { "--max-line-length", "88", "--max-complexity", "18", "--select", "B,C,E,F,W,T4,B9", "--ignore", "E266,E501,E402" }
      }),
      formatting.black.with({
        extra_args = { "--line-length", "160" }
      }),
      formatting.isort,
      --.with({
      --  args = { "--stdout", "--filename", "$FILENAME", "-" }
      --}),
      formatting.stylua,
      formatting.autoflake,
      formatting.isort.with({
        args = { "--profile", "black", "--filter-files"}
      }),
      diagnostics.mypy.with({
        extra_args = { "--ignore-missing-imports" },
        --prefer_local = ".venv/lib/python3.11/site-packages/mypy",
      }),
      diagnostics.pydocstyle,
      diagnostics.eslint_d,
      code_actions.eslint_d,
      formatting.prettierd,
    }
}
