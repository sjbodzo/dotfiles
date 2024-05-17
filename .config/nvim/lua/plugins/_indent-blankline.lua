-----------------------------------------------------------
-- Indent line configuration file
-----------------------------------------------------------

-- Plugin: indent-blankline
-- url: https://github.com/lukas-reineke/indent-blankline.nvim


local status_ok, indent_blankline = pcall(require, 'ibl')
if not status_ok then
  return
end

indent_blankline.setup {
  enabled = false,
  indent= {
      char = "|",
  },
  exclude = {
      filetypes = {
        'lspinfo',
        'packer',
        'checkhealth',
        'help',
        'man',
        'dashboard',
        'git',
        'markdown',
        'text',
        'terminal',
        'NvimTree',
      },
      buftypes = {
        'terminal',
        'nofile',
        'quickfix',
        'prompt',
      },
  },
}
