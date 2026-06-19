local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

function M.get(colors, opts)
  return {
    TelescopeNormal = { link = "NormalFloat" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },
    TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_alt },
    TelescopePromptBorder = { fg = colors.teal, bg = colors.bg_alt },
    TelescopePromptPrefix = { fg = colors.accent },
    TelescopeSelection = { link = "Visual" },
    TelescopeSelectionCaret = { fg = colors.accent },
    TelescopeMatching = { fg = colors.yellow, bold = true },
    TelescopePreviewLine = { link = "CursorLine" },
  }
end

return M
