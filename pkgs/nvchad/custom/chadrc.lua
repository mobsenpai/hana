---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "gruvbox",
  theme_toggle = {},

   statusline = {
    theme = "default",
    separator_style = "block",
  },

  nvdash = {
    load_on_startup = true,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
-- M.mappings = require "custom.mappings"

return M
