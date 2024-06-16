-- Change leader to a comma before init of lazy to ensure
-- that any mappings set here use the correct <leader> and
-- not the default <leader> of '\'
vim.g.mapleader = ','

-- Automatically install lazy
local fn = vim.fn
local lazy_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

local status_ok, plugin = pcall(require, "lazy")
if not status_ok then return end

local opts = {
  defaults = {
    lazy = false,
  },
  lockfile = fn.stdpath("config") .. "/.lazy-lock.json",
  concurrency = 50,
  install = {
    missing = true,
    colorscheme = { "onenord" },
  },
  ui = {
    size = {
      width = 0.9,
      height = 0.9
    },
  },
}

local plugins = {
  -- file explorer
  {
    'kyazdani42/nvim-tree.lua',
    config = function() require('plugins._nvim-tree') end
  },

  -- indent line
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins._indent-blankline') end
  },

  { "neovim/nvim-lspconfig" },

  {
    'astral-sh/ruff-lsp',
    --after = { 'nvim-lspconfig' },
    config = function() require('plugins._ruff') end
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- Set up autocomplete for the lsp
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/vim-vsnip',
    },
    config = function()
      require('plugins._nvim-cmp')
    end
  },

  -- neovim lsp shim for plugins to augment lsp
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function() require('plugins._null-ls') end,
    -- after = { "nvim-lspconfig" }
  },

  -- "batteries included" rust lsp config
  {
    'simrat39/rust-tools.nvim',
    config = function() require('plugins._rust-tools') end,
    -- after = { "nvim-lspconfig" }
  },

  -- icons
  {
    'kyazdani42/nvim-web-devicons',
    config = function() require('plugins._nvim-web-devicons') end
  },

  -- tag viewer
  { 'preservim/tagbar' },

  -- Treesitter interface
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins._nvim-treesitter') end
  },

  -- hook up debugging through xcode debugger
  'puremourning/vimspector',

  -- Color schemes
  { 'navarasu/onedark.nvim' },
  { 'tanvirtin/monokai.nvim' },
  { 'rose-pine/neovim',      as = 'rose-pine' },

  -- Statusline
  {
    'feline-nvim/feline.nvim',
    config = function() require('plugins._feline') end
  },

  -- Dashboard (start screen)
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('plugins._alpha-nvim') end
  },

  -- Set up pop up to input commands as I work
  { 'voldikss/vim-floaterm' },

  -- Set up quick notes in file
  {
    "RutaTang/quicknote.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require('plugins._quicknote') end
  },

  -- Set up fuzzy search
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function() require('plugins._telescope') end
  },

  -- Set up markdown mermaid preview
  -- {
  --"iamcco/markdown-preview.nvim",
  --  	run = "cd app && npm install",
  --setup = function()
  --	vim.g.mkdp_filetypes = { "markdown" }
  --end,
  --ft = { "markdown" },
  -- },

  -- Set up calendar integration
  { "mattn/calendar-vim" },

  -- Set up zettelkasten
  {
    "renerocksai/telekasten.nvim",
    event = "VeryLazy",
    dependencies = { "mattn/calendar-vim" },
    config = function() require('plugins._telekasten') end
  },

  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup({
        auto_load = true,      -- whether to automatically load preview when
        -- entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete

        syntax = true,         -- enable syntax highlighting, affects performance

        theme = 'dark',        -- 'dark' or 'light'

        update_on_change = true,

        app = 'webview', -- 'webview', 'browser', string or a table of strings
        -- explained below

        filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this
        -- amount of bytes in size
        throttle_time = 'auto', -- minimum amount of time in milliseconds
        -- that has to pass before starting new render
      })
    end
  },

  { 'f-person/git-blame.nvim' },

  {
    'sindrets/diffview.nvim',
    config = function() require('plugins._diffview') end
  },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'global',

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),
      })
    end
  },

  -- nicer diagnostics in my editor with symbol lookups
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
        "luvit-meta/library", -- see below
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  {"shortcuts/no-neck-pain.nvim", version = "*"},
}

plugin.setup(plugins, opts)
