-- manually register the starlark TS grammar to apply to tiltfile filetype
vim.treesitter.language.register('starlark', { 'starlark', 'tiltfile' })
