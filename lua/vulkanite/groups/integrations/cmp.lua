local M = {}

M.url = "https://github.com/hrsh7th/nvim-cmp"

function M.get(colors, opts)
  return {
    -- Nvim-cmp documentation popup body.
    CmpDocumentation = { link = "NormalFloat" },
    -- Nvim-cmp documentation popup border.
    CmpDocumentationBorder = { link = "FloatBorder" },
    -- Nvim-cmp completion item abbreviation text.
    CmpItemAbbr = { fg = colors.fg },
    -- Nvim-cmp deprecated completion item abbreviation text.
    CmpItemAbbrDeprecated = { fg = colors.comment, strikethrough = true },
    -- Nvim-cmp characters in abbreviations that match the query.
    CmpItemAbbrMatch = { fg = colors.accent, bold = true },
    -- Nvim-cmp fuzzy-matched characters in abbreviations.
    CmpItemAbbrMatchFuzzy = { fg = colors.teal, bold = true },
    -- Nvim-cmp completion item menu text.
    CmpItemMenu = { fg = colors.comment },
    -- Nvim-cmp completion kind icon.
    CmpItemKind = { fg = colors.purple },
    -- Nvim-cmp function kind icon.
    CmpItemKindFunction = { link = "LspKindFunction" },
    -- Nvim-cmp variable kind icon.
    CmpItemKindVariable = { link = "LspKindVariable" },
    -- Nvim-cmp class kind icon.
    CmpItemKindClass = { link = "LspKindClass" },
  }
end

return M
