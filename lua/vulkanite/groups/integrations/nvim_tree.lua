local M = {}

M.url = "https://github.com/nvim-tree/nvim-tree.lua"

function M.get(colors, opts)
  return {
    NvimTreeNormal = { link = "Normal" },
    NvimTreeNormalNC = { link = "NormalNC" },
    NvimTreeFolderIcon = { fg = colors.accent },
    NvimTreeFolderName = { fg = colors.accent },
    NvimTreeOpenedFolderName = { fg = colors.teal, bold = true },
    NvimTreeEmptyFolderName = { fg = colors.comment },
    NvimTreeRootFolder = { fg = colors.accent, bold = true },
    NvimTreeGitNew = { link = "Added" },
    NvimTreeGitDirty = { link = "Changed" },
    NvimTreeGitDeleted = { link = "Removed" },
    NvimTreeIndentMarker = { fg = colors.gutter },
    NvimTreeWinSeparator = { link = "WinSeparator" },
  }
end

return M
