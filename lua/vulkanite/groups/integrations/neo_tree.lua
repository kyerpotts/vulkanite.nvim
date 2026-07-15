local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

function M.get(colors, opts)
  return {
    -- Neo-tree current-window body text.
    NeoTreeNormal = { link = "Normal" },
    -- Neo-tree non-current-window body text.
    NeoTreeNormalNC = { link = "NormalNC" },
    -- Neo-tree directory icons.
    NeoTreeDirectoryIcon = { fg = colors.accent },
    -- Neo-tree directory names.
    NeoTreeDirectoryName = { fg = colors.accent },
    -- Neo-tree file names.
    NeoTreeFileName = { fg = colors.fg },
    -- Neo-tree opened file name.
    NeoTreeFileNameOpened = { fg = colors.teal, bold = true },
    -- Neo-tree git marker for added files.
    NeoTreeGitAdded = { link = "Added" },
    -- Neo-tree git marker for modified files.
    NeoTreeGitModified = { link = "Changed" },
    -- Neo-tree git marker for deleted files.
    NeoTreeGitDeleted = { link = "Removed" },
    -- Neo-tree indentation guide markers.
    NeoTreeIndentMarker = { fg = colors.gutter },
    -- Neo-tree root directory name.
    NeoTreeRootName = { fg = colors.accent, bold = true },
    -- Neo-tree active source tab.
    NeoTreeTabActive = { link = "TabLineSel" },
    -- Neo-tree inactive source tab.
    NeoTreeTabInactive = { link = "TabLine" },
  }
end

return M
