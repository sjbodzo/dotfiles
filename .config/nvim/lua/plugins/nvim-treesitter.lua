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

    local nvim_treesitter_configs = require('nvim-treesitter.configs')

    -- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
    nvim_treesitter.setup {
      -- A list of parser names, or "all"
      ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
        'rust', 'typescript', 'vim', 'yaml', 'go',
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
      },
    }

    nvim_treesitter_configs.setup {
      ensure_installed = { "lua", "rust", "toml", "python", "typescript", "go", "yaml", "go" },
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
