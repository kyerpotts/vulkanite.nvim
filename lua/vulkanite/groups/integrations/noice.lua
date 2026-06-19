local M = {}

M.url = "https://github.com/folke/noice.nvim"

function M.get(colors, opts)
  return {
    NoiceCmdline = { link = "NormalFloat" },
    NoiceCmdlinePopup = { link = "NormalFloat" },
    NoiceCmdlinePopupBorder = { link = "FloatBorder" },
    NoiceCmdlinePopupTitle = { link = "FloatTitle" },
    NoiceCmdlineIcon = { fg = colors.accent },
    NoiceConfirm = { link = "NormalFloat" },
    NoiceConfirmBorder = { link = "FloatBorder" },
    NoiceFormatProgressDone = { fg = colors.ok },
    NoiceFormatProgressTodo = { fg = colors.gutter },
    NoiceLspProgressClient = { fg = colors.teal },
    NoiceLspProgressTitle = { fg = colors.fg },
    NoiceVirtualText = { link = "DiagnosticVirtualTextInfo" },
  }
end

return M
