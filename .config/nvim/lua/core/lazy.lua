-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

-- Change leader to a comma before init of lazy to ensure
-- that any mappings set here use the correct <leader> and
-- not the default <leader> of '\'
require("helpers.keys").set_leader(",")

local opts = {
  defaults = {
    lazy = false,
  },
  lockfile = vim.fn.stdpath("config") .. "/.lazy-lock.json",
  concurrency = 50,
  install = {
    missing = true,
  },
  ui = {
    size = {
      width = 0.9,
      height = 0.9
    },
  },
}
lazy.setup("plugins", opts)

require("helpers.keys").map("n", "<leader>L", lazy.show, { desc = 'Show Lazy' })
