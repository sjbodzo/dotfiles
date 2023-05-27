local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup{}
lspconfig.pylsp.setup {}
--  settings = {
--    pylsp = {
--      plugins = {
--        black = {
--          enabled = true,
--          line_length = 160
--        },
--        pycodestyle = {
--          enabled = false,
--          ignore = {},
--          maxLineLength = 100
--        },
--        flake8 = {
--          enabled = true,
--          select = "B,C,E,F,W,T4,B9",
--          ignore = "E266,E501,E402",
--        },
--        mypy = {
--          enabled = true,
--          ignore_missing_imports = true
--        }
--      }
--    }
--  }
-- }
