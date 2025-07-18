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

-- manually add helm filetype detection to differentiate from regular yaml
-- as otherwise the editor makes your eyes bleed on template blocks
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
  }
})
