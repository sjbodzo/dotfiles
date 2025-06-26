-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
    if not status_ok then
      return
    end

    nvim_treesitter.setup {
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      ensure_installed = { "bash", "cpp", "css", "javascript", "json", "vim", "lua", "rust", "toml", "python", "typescript", "yaml", "go", "starlark" },
      auto_install = true,
      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting=false,
      },
      ident = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      }
    }
  end
}
