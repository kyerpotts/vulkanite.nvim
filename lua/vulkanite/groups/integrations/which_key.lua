local M = {}

M.url = "https://github.com/folke/which-key.nvim"

function M.get(colors, opts)
  return {
    -- Which-key key label in the popup.
    WhichKey = { fg = colors.accent, bold = true },
    -- Which-key group name in the popup.
    WhichKeyGroup = { fg = colors.accent },
    -- Which-key mapping description text.
    WhichKeyDesc = { fg = colors.fg },
    -- Which-key separator between keys and descriptions.
    WhichKeySeparator = { fg = colors.comment },
    -- Which-key popup body.
    WhichKeyFloat = { link = "NormalFloat" },
    -- Which-key popup border.
    WhichKeyBorder = { link = "FloatBorder" },
    -- Which-key value text for dynamic mappings.
    WhichKeyValue = { fg = colors.comment },
    -- Which-key icon beside a mapping or group.
    WhichKeyIcon = { fg = colors.purple },
    -- Which-key popup title.
    WhichKeyTitle = { link = "FloatTitle" },
  }
end

return M
