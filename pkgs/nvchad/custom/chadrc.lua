---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "gruvbox",
  theme_toggle = {},

   statusline = {
    theme = "default",
    separator_style = "block",
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
-- M.mappings = require "custom.mappings"

return M
