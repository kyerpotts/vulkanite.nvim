local M = {}

M.url = "https://github.com/saghen/blink.cmp"

function M.get(colors, opts)
  return {
    -- Blink.cmp completion menu body.
    BlinkCmpMenu = { link = "Pmenu" },
    -- Blink.cmp completion menu border.
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    -- Blink.cmp selected completion item.
    BlinkCmpMenuSelection = { link = "PmenuSel" },
    -- Blink.cmp completion item label text.
    BlinkCmpLabel = { fg = colors.fg },
    -- Blink.cmp deprecated completion item label text.
    BlinkCmpLabelDeprecated = { fg = colors.comment, strikethrough = true },
    -- Blink.cmp characters in labels that match the query.
    BlinkCmpLabelMatch = { fg = colors.accent, bold = true },
    -- Blink.cmp completion kind icon.
    BlinkCmpKind = { fg = colors.icon },
    -- Blink.cmp completion item source name.
    BlinkCmpSource = { fg = colors.comment },
    -- Blink.cmp documentation popup body.
    BlinkCmpDoc = { link = "NormalFloat" },
    -- Blink.cmp documentation popup border.
    BlinkCmpDocBorder = { link = "FloatBorder" },
    -- Blink.cmp signature-help popup body.
    BlinkCmpSignatureHelp = { link = "NormalFloat" },
  }
end

return M
