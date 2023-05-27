-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-- ensure we use homembrew copy of exuberant ctags
vim.g.tagbar_ctags_bin = '/usr/local/bin/ctags'

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
-- map('', '<up>', '<nop>')
-- map('', '<down>', '<nop>')
-- map('', '<left>', '<nop>')
-- map('', '<right>', '<nop>')

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<F2>'

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Tagbar
map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

-- Vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
map('n', "Dw", ":call vimspector#AddWatch()<cr>")
map('n', "De", ":call vimspector#Evaluate()<cr>")

-- Telescope shortcuts for fuzzy search
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Language server key mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
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
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

local null_ls = require('null-ls')
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

require('null-ls').setup{
    sources = {
      diagnostics.flake8.with({
        args = { "--stdin-display-name", "$FILENAME", "-" },
        extra_args = { "--max-line-length=88", "--max-complexity=18", "--select=B,C,E,F,W,T4,B9", "--ignore=E266,E501,E402" }
      }),
      formatting.black,
      formatting.isort,
      formatting.stylua,
      formatting.autoflake,
      formatting.isort,
      diagnostics.mypy,
      diagnostics.pydocstyle,
      diagnostics.eslint_d,
      code_actions.eslint_d,
      formatting.prettierd,
    }
}


-- zettlekasten setup
vim.cmd([[
  nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
  nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
  nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
  nnoremap <leader>zz :lua require('telekasten').follow_link()<CR>
  nnoremap <leader>zT :lua require('telekasten').goto_today()<CR>
  nnoremap <leader>zW :lua require('telekasten').goto_thisweek()<CR>
  nnoremap <leader>zw :lua require('telekasten').find_weekly_notes()<CR>
  nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
  nnoremap <leader>zN :lua require('telekasten').new_templated_note()<CR>
  nnoremap <leader>zy :lua require('telekasten').yank_notelink()<CR>
  nnoremap <leader>zc :lua require('telekasten').show_calendar()<CR>
  nnoremap <leader>zC :CalendarT<CR>
  nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
  nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
  nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
  nnoremap <leader>zF :lua require('telekasten').find_friends()<CR>
  nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
  nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
  nnoremap <leader>zm :lua require('telekasten').browse_media()<CR>
  nnoremap <leader>za :lua require('telekasten').show_tags()<CR>
  nnoremap <leader># :lua require('telekasten').show_tags()<CR>
  nnoremap <leader>zr :lua require('telekasten').rename_note()<CR>

  " on hesitation, bring up the panel
  nnoremap <leader>z :lua require('telekasten').panel()<CR>

  " we could define [[ in **insert mode** to call insert link
  " inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
  " alternatively: leader [
  inoremap <leader>[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
  inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>
  inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>

  hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
  hi tkBrackets ctermfg=gray guifg=gray

  hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
  " hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

  hi link CalNavi CalRuler
  hi tkTagSep ctermfg=gray guifg=gray
  hi tkTag ctermfg=175 guifg=#d3869B
]])

