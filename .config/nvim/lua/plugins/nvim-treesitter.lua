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
      ensure_installed = { "bash", "cpp", "css", "html", "javascript", "json", "vim", "lua", "rust", "toml", "python", "typescript", "yaml", "go", "starlark" },
      auto_install = true,
      highlight = {
        enable = true,
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
