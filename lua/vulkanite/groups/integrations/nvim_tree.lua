local M = {}

M.url = "https://github.com/nvim-tree/nvim-tree.lua"

function M.get(colors, opts)
  return {
    -- Nvim-tree current-window body text.
    NvimTreeNormal = { link = "Normal" },
    -- Nvim-tree non-current-window body text.
    NvimTreeNormalNC = { link = "NormalNC" },
    -- Nvim-tree folder icons.
    NvimTreeFolderIcon = { fg = colors.accent },
    -- Nvim-tree folder names.
    NvimTreeFolderName = { fg = colors.accent },
    -- Nvim-tree opened folder names.
    NvimTreeOpenedFolderName = { fg = colors.teal, bold = true },
    -- Nvim-tree empty folder names.
    NvimTreeEmptyFolderName = { fg = colors.comment },
    -- Nvim-tree root folder name.
    NvimTreeRootFolder = { fg = colors.accent, bold = true },
    -- Nvim-tree git marker for new files.
    NvimTreeGitNew = { link = "Added" },
    -- Nvim-tree git marker for dirty files.
    NvimTreeGitDirty = { link = "Changed" },
    -- Nvim-tree git marker for deleted files.
    NvimTreeGitDeleted = { link = "Removed" },
    -- Nvim-tree indentation guide markers.
    NvimTreeIndentMarker = { fg = colors.gutter },
    -- Nvim-tree window separator.
    NvimTreeWinSeparator = { link = "WinSeparator" },
  }
end

return M
