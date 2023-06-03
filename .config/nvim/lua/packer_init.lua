-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({
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
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua', config = function() require('plugins._nvim-tree') end }

  -- Indent line
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins._indent-blankline') end
  }

  -- Mason is a package manager that manages LSP server, linters, debuggers;
  -- Here we bridge mason with lspconfig
  use {
    "williamboman/mason.nvim",
    config = function()
      require('plugins._mason')
    end
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('plugins._mason-lspconfig')
    end,
    after = {"mason.nvim"}
  }

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require('plugins._lspconfig')
    end
  }


  -- Set up autocomplete for the lsp
    -- Completion framework:
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins._nvim-cmp')
    end
  }

  -- LSP completion source:
  use {
    'hrsh7th/cmp-nvim-lsp',
    after = { "nvim-cmp" },
  }
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function() require('plugins._null-ls') end,
    after = { "nvim-lspconfig" }
  }

  use {
    'simrat39/rust-tools.nvim',
    config = function() require('plugins._rust-tools') end,
    after = { "nvim-lspconfig" }
  }

  -- Icons
  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require('plugins._nvim-web-devicons') end
  }

  -- Tag viewer
  use 'preservim/tagbar'

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins._nvim-treesitter') end
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
    config = function() require('plugins._feline') end
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup{} end
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('plugins._alpha-nvim') end
  }

  -- Set up pop up to input commands as I work
  use 'voldikss/vim-floaterm'

  -- Set up fuzzy search
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function() require('plugins._telescope') end
  }

  -- Set up markdown mermaid preview
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  -- Set up calendar integration
  use({ "mattn/calendar-vim" })

  -- Set up zettelkasten
  use {
    "renerocksai/telekasten.nvim",
    requires = { "mattn/calendar-vim" },
    config = function() require('plugins._telekasten') end
  }

  use 'github/copilot.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    require('packer').sync()
  end
end)
