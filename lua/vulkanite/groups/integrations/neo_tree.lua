local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

function M.get(colors, opts)
  return {
    NeoTreeNormal = { link = "Normal" },
    NeoTreeNormalNC = { link = "NormalNC" },
    NeoTreeDirectoryIcon = { fg = colors.accent },
    NeoTreeDirectoryName = { fg = colors.accent },
    NeoTreeFileName = { fg = colors.fg },
    NeoTreeFileNameOpened = { fg = colors.teal, bold = true },
    NeoTreeGitAdded = { link = "Added" },
    NeoTreeGitModified = { link = "Changed" },
    NeoTreeGitDeleted = { link = "Removed" },
    NeoTreeIndentMarker = { fg = colors.gutter },
    NeoTreeRootName = { fg = colors.purple, bold = true },
    NeoTreeTabActive = { link = "TabLineSel" },
    NeoTreeTabInactive = { link = "TabLine" },
  }
end

return M
