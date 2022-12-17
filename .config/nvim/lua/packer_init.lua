-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- Mason manages LSP server, linters, debuggers
  use 'williamboman/mason-lspconfig.nvim'
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup{}
      require('mason-lspconfig').setup({
        ensure_installed = {
          "rust_analyzer",
          "tsserver",
          "sumneko_lua",
          "marksman",
          "rnix",
          "pyright",
          "sqlls",
          "yamlls",
          "gopls",
          "bashls"
      }
      })
    end
  }

  -- Connect configs for the LSP servers
  use 'neovim/nvim-lspconfig'

  use 'simrat39/rust-tools.nvim'

  -- Set up autocomplete for the lsp
    -- Completion framework:
  use 'hrsh7th/nvim-cmp'

  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'

  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  -- end autocomplete plugins

  -- Autopair
  -- Note: disabled because of weird issue where it prevents you typing chars
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{}
  --   end
  -- }

  -- Icons
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
         };
         -- globally enable different highlight colors per icon (default to true)
         -- if set to false all icons will have the default icon's color
         color_icons = true;
         -- globally enable default icons (default to false)
         -- will get overriden by `get_icons` option
         default = true;
      }
    end
  }

  -- Tag viewer
  use 'preservim/tagbar'

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = { "lua", "rust", "toml" },
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

  -- hook up debugging through xcode debugger
  use 'puremourning/vimspector'

  -- Color schemes
  use 'navarasu/onedark.nvim'
  use 'tanvirtin/monokai.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup{}
    end
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }

  -- Set up pop up to input commands as I work
  use 'voldikss/vim-floaterm'

  -- Set up fuzzy search
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    require('telescope').setup{}
  end
}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
