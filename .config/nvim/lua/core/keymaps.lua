local keymap = vim.api.nvim_set_keymap

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
-- vim.opt.pastetoggle = '<F2>'

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
-- map('n', '<C-t>', ':Term<CR>', { noremap = true }) -- open
map('n', '<C-t>', ':tabnew<CR>', { noremap = true }) -- open
map('t', '<Esc>', '<C-\\><C-n>')                   -- exit

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')       -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')  -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>') -- search file

-- Tagbar
map('n', '<leader>z', ':TagbarToggle<CR>') -- open/close

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
local rel_live_grep = function ()
  builtin.live_grep({ cwd = require("telescope.utils").buffer_dir()})
end

-- set key mappings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', rel_live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Language server key mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

--local lsp_flags = {
--  -- This is the default in Nvim 0.7+
--  debounce_text_changes = 150,
--}
--require('lspconfig')['pyright'].setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--}
--require('lspconfig')['tsserver'].setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--}
--require('lspconfig')['gopls'].setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--}
--require('lspconfig')['rust_analyzer'].setup{
--    on_attach = on_attach,
--    flags = lsp_flags,
--    -- Server-specific settings...
--    settings = {
--      ["rust-analyzer"] = {}
--    }
--}

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

-- Copilot config (overwrite tab for nvim-cmp to use)
keymap('i', '<C-\\>', '<Plug>(copilot-dismiss)',
  { silent = true, noremap = true, desc = "Dismiss copilot suggestion" })
keymap('i', '<C-k>', 'copilot#Previous()', { expr = true, silent = true, desc =
"Previous copilot suggestion" })
keymap('i', '<C-j>', 'copilot#Next()', { expr = true, silent = true, desc = "Next copilot suggestion" })
keymap('i', '<C-s>', 'copilot#Suggest()', { expr = true, silent = true, desc = "Suggest copilot" })
keymap('i', '<C-a>', 'copilot#Accept("<CR>")',
  { expr = true, silent = true, desc = "Accept copilot suggestion" })

-- Markdown Preview
vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

-- Quicknote shortcuts
--keymap("n", "<leader>sn", "<cmd>:lua require('quicknote').ShowNoteSigns()<CR>",{ noremap = true, desc = "New note at CWD" })
--keymap("n", "<leader>cn", "<cmd>:lua require('quicknote').NewNoteAtCWD()<CR>",{ noremap = true, desc = "New note at CWD" })
--keymap("n", "<leader>pn", "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<CR>",{ noremap = true, desc = "Create quick note at line" })
--keymap("n", "<leader>on", "<cmd>:lua require('quicknote').OpenNoteAtCurrentLine()<CR>",{ noremap = true, desc = "Open note at line" })
--keymap("n", "<leader>ln", "<cmd>:lua require('quicknote').ListNotesForCWD()<CR>",{ noremap = true, desc = "List notes at CWD" })
--keymap("n", "<leader>rn", "<cmd>:lua require('quicknote').DeleteNoteAtCurrentLine()<CR>",{ noremap = true, desc = "Delete note at line" })
--keymap("n", "<leader>jn", "<cmd>:lua require('quicknote').JumpToNextNote()<CR>",{ noremap = true, desc = "Jump to next note" })
--keymap("n", "<leader>jN", "<cmd>:lua require('quicknote').JumpToPreviousNote()<CR>",{ noremap = true, desc = "Jump to previous note" })
