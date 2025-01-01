-- icons
return {
  'kyazdani42/nvim-web-devicons',
  config = function()
    local nvim_web_devicons = require('nvim-web-devicons')

    nvim_web_devicons.setup {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh"
        }
       };
       -- globally enable different highlight colors per icon (default to true)
       -- if set to false all icons will have the default icon's color
       color_icons = true;
       -- globally enable default icons (default to false)
       -- will get overriden by `get_icons` option
       default = true;
    }
  end
}
