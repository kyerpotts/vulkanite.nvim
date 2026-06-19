local M = {}

M.url = "https://github.com/folke/which-key.nvim"

function M.get(colors, opts)
  return {
    WhichKey = { fg = colors.accent, bold = true },
    WhichKeyGroup = { fg = colors.accent },
    WhichKeyDesc = { fg = colors.fg },
    WhichKeySeparator = { fg = colors.comment },
    WhichKeyFloat = { link = "NormalFloat" },
    WhichKeyBorder = { link = "FloatBorder" },
    WhichKeyValue = { fg = colors.comment },
    WhichKeyIcon = { fg = colors.purple },
    WhichKeyTitle = { link = "FloatTitle" },
  }
end

return M
