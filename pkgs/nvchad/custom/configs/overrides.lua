local M = {}

M.treesitter = {
  ensure_installed = {
    "html",
    "css",
    "javascript",
    "lua",
    "nix",
  },
  indent = {
    enable = true,
    disable = {
      "python"
    },
  },
}

M.mason = {
  ensure_installed = {
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
