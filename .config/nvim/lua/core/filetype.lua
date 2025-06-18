-- manually add tiltfile filetype detection for lsp via tilt_ls
vim.filetype.add({
  filename = {
    ["Tiltfile"] = "tiltfile",
  },
  pattern = {
    ["Tiltfile*"] = "tiltfile",
    ["tiltfile*"] = "tiltfile",
    ["*.Tiltfile"] = "tiltfile",
  }
})
