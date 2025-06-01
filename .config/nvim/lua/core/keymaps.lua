local keymaps = require('helpers.keys')
local map = keymaps.map
local lsp_map = keymaps.lsp_map

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

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
map('n', '<C-t>', ':tabnew<CR>') -- open
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
lsp_map('<leader>ff', builtin.find_files)
lsp_map('<leader>fg', rel_live_grep)
lsp_map('<leader>fb', builtin.buffers)
lsp_map('<leader>fh', builtin.help_tags)

-- Language server key mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
lsp_map('<space>e', vim.diagnostic.open_float)
lsp_map(']d', function() vim.diagnostic.jump({count=1, float=true}) end)
lsp_map('[d', function() vim.diagnostic.jump({count=-1, float=true}) end)
lsp_map('<space>q', vim.diagnostic.setloclist)

-- zettlekasten setup
lsp_map('zf', function() require('telekasten').find_notes() end)
lsp_map('zd', function() require('telekasten').find_daily_notes() end)
lsp_map('zg', function() require('telekasten').search_notes() end)
lsp_map('zz', function() require('telekasten').follow_link() end)
lsp_map('zT', function() require('telekasten').goto_today() end)
lsp_map('zW', function() require('telekasten').goto_thisweek() end)
lsp_map('zw', function() require('telekasten').find_weekly_notes() end)
lsp_map('zn', function() require('telekasten').new_note() end)
lsp_map('zN', function() require('telekasten').new_templated_note() end)
lsp_map('zy', function() require('telekasten').yank_notelink() end)
lsp_map('zc', function() require('telekasten').show_calendar() end)
lsp_map('zi', function() require('telekasten').paste_img_and_link() end)
lsp_map('zt', function() require('telekasten').toggle_todo() end)
lsp_map('zb', function() require('telekasten').show_backlinks() end)
lsp_map('zF', function() require('telekasten').find_friends() end)
lsp_map('zI', function() require('telekasten').insert_img_link({ i=true }) end)
lsp_map('zp', function() require('telekasten').preview_img() end)
lsp_map('zm', function() require('telekasten').browse_media() end)
lsp_map('za', function() require('telekasten').show_tags() end)
lsp_map('#', function() require('telekasten').show_tags() end)
lsp_map('zr', function() require('telekasten').rename_note() end)
lsp_map('z', function() require('telekasten').panel() end)
lsp_map('[', function() require('telekasten').insert_link({ i=true }) end)
lsp_map('zt', function() require('telekasten').toggle_todo({ i=true }) end)
lsp_map('#', function() require('telekasten').show_tags({i = true}) end)

-- zettlekasten customize highlights
-- https://github.com/nvim-telekasten/telekasten.nvim?tab=readme-ov-file#highlights-1
--[[
-- tkLink : the link title inside the brackets
-- tkAliasedLink : the concealed portion of [[concealed link|link alias]]
-- tkBrackets : the brackets surrounding the link title
-- tkHighlight : ==highlighted== text (non-standard markdown)
-- tkTag : well, tags
--]]
vim.cmd([[
  hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
  hi tkBrackets ctermfg=gray guifg=gray
  hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
  hi link CalNavi CalRuler
  hi tkTagSep ctermfg=gray guifg=gray
  hi tkTag ctermfg=175 guifg=#d3869B
]])

-- Copilot config (overwrite tab for nvim-cmp to use)
map('i', '<C-\\>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss copilot suggestion' })
map('i', '<C-k>', 'copilot#Previous()', { desc = 'Previous copilot suggestion' })
map('i', '<C-j>', 'copilot#Next()', { desc = 'Next copilot suggestion' })
map('i', '<C-s>', 'copilot#Suggest()', { desc = 'Suggest copilot' })
map('i', '<C-a>', 'copilot#Accept("<CR>")', { desc = 'Accept copilot suggestion' })

-- Markdown Preview
vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
