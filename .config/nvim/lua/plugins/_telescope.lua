local lga_actions = require("telescope-live-grep-args.actions")
local actions = require("telescope.actions")
local telescope = require("telescope")

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add
local open_with_trouble = require("trouble.sources.telescope").open

-- sourced from https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
-- allows multi select / open in telescope buffer
local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

telescope.setup {
  defaults = {
    mappings = { -- extend mappings
      i = {
        ['<CR>'] = select_one_or_multi,
        ["<C-J>"] = lga_actions.move_selection_next,
        ["<C-K>"] = lga_actions.move_selection_previous,
        ["<TAB>"] = lga_actions.toggle_selection,
        ["<c-t>"] = open_with_trouble,
      },
      n = { ["<c-t>"] = open_with_trouble },
    }
  },
  extensions = {
    quicknote = {
      defaultScope = "CWD",
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {      -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    }
  }
}

telescope.load_extension("quicknote")
telescope.load_extension("live_grep_args")


