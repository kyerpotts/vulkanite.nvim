local M = {}

M.url = "https://github.com/folke/noice.nvim"

function M.get(colors, opts)
  return {
    -- Noice command-line message area.
    NoiceCmdline = { link = "NormalFloat" },
    -- Noice command-line popup body.
    NoiceCmdlinePopup = { link = "NormalFloat" },
    -- Noice command-line popup border.
    NoiceCmdlinePopupBorder = { link = "FloatBorder" },
    -- Noice command-line popup title.
    NoiceCmdlinePopupTitle = { link = "FloatTitle" },
    -- Noice command-line mode icon.
    NoiceCmdlineIcon = { fg = colors.accent },
    -- Noice confirmation dialog body.
    NoiceConfirm = { link = "NormalFloat" },
    -- Noice confirmation dialog border.
    NoiceConfirmBorder = { link = "FloatBorder" },
    -- Noice completed progress segment.
    NoiceFormatProgressDone = { fg = colors.ok },
    -- Noice incomplete progress segment.
    NoiceFormatProgressTodo = { fg = colors.gutter },
    -- Noice LSP progress client name.
    NoiceLspProgressClient = { fg = colors.accent_secondary },
    -- Noice LSP progress title text.
    NoiceLspProgressTitle = { fg = colors.fg },
    -- Noice virtual text messages.
    NoiceVirtualText = { link = "DiagnosticVirtualTextInfo" },
  }
end

return M
