local M = {}

M.map = function(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

M.lsp_map = function(lhs, rhs, bufnr, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
	M.map("n", lhs, rhs, options)
end

M.dap_map = function(mode, lhs, rhs, desc)
	M.map(mode, lhs, rhs, desc)
end

M.set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	M.map({ "n", "v" }, key, "<nop>")
end

return M
