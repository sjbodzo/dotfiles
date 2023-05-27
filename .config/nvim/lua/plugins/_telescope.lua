local lga_actions = require("telescope-live-grep-args.actions")
local telescope = require("telescope")

telescope.load_extension("live_grep_args")
telescope.setup{
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {         -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    }
  }
}
