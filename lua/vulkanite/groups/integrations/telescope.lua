local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

function M.get(colors, opts)
  return {
    -- Telescope picker body.
    TelescopeNormal = { link = "NormalFloat" },
    -- Telescope picker border.
    TelescopeBorder = { link = "FloatBorder" },
    -- Telescope picker title text.
    TelescopeTitle = { link = "FloatTitle" },
    -- Telescope prompt input area.
    TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_alt },
    -- Telescope prompt input border.
    TelescopePromptBorder = { fg = colors.teal, bg = colors.bg_alt },
    -- Telescope prompt prefix icon.
    TelescopePromptPrefix = { fg = colors.accent },
    -- Telescope currently selected result row.
    TelescopeSelection = { link = "Visual" },
    -- Telescope selection caret beside the current result.
    TelescopeSelectionCaret = { fg = colors.accent },
    -- Telescope characters matched by the query.
    TelescopeMatching = { fg = colors.yellow, bold = true },
    -- Telescope preview line for the current result.
    TelescopePreviewLine = { link = "CursorLine" },
  }
end

return M
