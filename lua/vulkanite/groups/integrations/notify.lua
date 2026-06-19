local M = {}

M.url = "https://github.com/rcarriga/nvim-notify"

function M.get(colors, opts)
  return {
    NotifyERRORBorder = { fg = colors.error },
    NotifyWARNBorder = { fg = colors.warn },
    NotifyINFOBorder = { fg = colors.info },
    NotifyDEBUGBorder = { fg = colors.comment },
    NotifyTRACEBorder = { fg = colors.teal },
    NotifyERRORIcon = { fg = colors.error },
    NotifyWARNIcon = { fg = colors.warn },
    NotifyINFOIcon = { fg = colors.info },
    NotifyDEBUGIcon = { fg = colors.comment },
    NotifyTRACEIcon = { fg = colors.purple },
    NotifyERRORTitle = { fg = colors.error, bold = true },
    NotifyWARNTitle = { fg = colors.warn, bold = true },
    NotifyINFOTitle = { fg = colors.info, bold = true },
    NotifyDEBUGTitle = { fg = colors.comment, bold = true },
    NotifyTRACETitle = { fg = colors.teal, bold = true },
  }
end

return M
