local M = {}

M.url = "https://github.com/hrsh7th/nvim-cmp"

function M.get(colors, opts)
  return {
    CmpDocumentation = { link = "NormalFloat" },
    CmpDocumentationBorder = { link = "FloatBorder" },
    CmpItemAbbr = { fg = colors.fg },
    CmpItemAbbrDeprecated = { fg = colors.comment, strikethrough = true },
    CmpItemAbbrMatch = { fg = colors.accent, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = colors.teal, bold = true },
    CmpItemMenu = { fg = colors.comment },
    CmpItemKind = { fg = colors.purple },
    CmpItemKindFunction = { link = "LspKindFunction" },
    CmpItemKindVariable = { link = "LspKindVariable" },
    CmpItemKindClass = { link = "LspKindClass" },
  }
end

return M
