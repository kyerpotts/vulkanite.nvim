local M = {}

M.url = "https://github.com/rcarriga/nvim-notify"

function M.get(colors, opts)
  return {
    -- Notify border for error notifications.
    NotifyERRORBorder = { fg = colors.error },
    -- Notify border for warning notifications.
    NotifyWARNBorder = { fg = colors.warn },
    -- Notify border for informational notifications.
    NotifyINFOBorder = { fg = colors.info },
    -- Notify border for debug notifications.
    NotifyDEBUGBorder = { fg = colors.comment },
    -- Notify border for trace notifications.
    NotifyTRACEBorder = { fg = colors.teal },
    -- Notify icon for error notifications.
    NotifyERRORIcon = { fg = colors.error },
    -- Notify icon for warning notifications.
    NotifyWARNIcon = { fg = colors.warn },
    -- Notify icon for informational notifications.
    NotifyINFOIcon = { fg = colors.info },
    -- Notify icon for debug notifications.
    NotifyDEBUGIcon = { fg = colors.comment },
    -- Notify icon for trace notifications.
    NotifyTRACEIcon = { fg = colors.purple },
    -- Notify title for error notifications.
    NotifyERRORTitle = { fg = colors.error, bold = true },
    -- Notify title for warning notifications.
    NotifyWARNTitle = { fg = colors.warn, bold = true },
    -- Notify title for informational notifications.
    NotifyINFOTitle = { fg = colors.info, bold = true },
    -- Notify title for debug notifications.
    NotifyDEBUGTitle = { fg = colors.comment, bold = true },
    -- Notify title for trace notifications.
    NotifyTRACETitle = { fg = colors.teal, bold = true },
  }
end

return M
