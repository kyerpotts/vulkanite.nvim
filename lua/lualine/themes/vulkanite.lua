local opts = require("vulkanite.config").extend()
local colors = require("vulkanite.colors").setup(opts)

return {
  -- Lualine colors when Neovim is in normal mode.
  normal = {
    -- Lualine primary normal-mode section.
    a = { bg = colors.accent, fg = colors.bg },
    -- Lualine secondary normal-mode section.
    b = { bg = colors.bg_alt, fg = colors.fg },
    -- Lualine filler normal-mode section.
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  -- Lualine colors when Neovim is in insert mode.
  insert = {
    -- Lualine primary insert-mode section.
    a = { bg = colors.ok, fg = colors.bg },
    -- Lualine secondary insert-mode section.
    b = { bg = colors.bg_alt, fg = colors.fg },
    -- Lualine filler insert-mode section.
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  -- Lualine colors when Neovim is in command-line mode.
  command = {
    -- Lualine primary command-mode section.
    a = { bg = colors.yellow, fg = colors.bg },
    -- Lualine secondary command-mode section.
    b = { bg = colors.bg_alt, fg = colors.fg },
    -- Lualine filler command-mode section.
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  -- Lualine colors when Neovim is in visual mode.
  visual = {
    -- Lualine primary visual-mode section.
    a = { bg = colors.yellow, fg = colors.bg },
    -- Lualine secondary visual-mode section.
    b = { bg = colors.bg_alt, fg = colors.fg },
    -- Lualine filler visual-mode section.
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  -- Lualine colors when Neovim is in replace mode.
  replace = {
    -- Lualine primary replace-mode section.
    a = { bg = colors.value, fg = colors.bg },
    -- Lualine secondary replace-mode section.
    b = { bg = colors.bg_alt, fg = colors.fg },
    -- Lualine filler replace-mode section.
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  -- Lualine colors when Neovim is in terminal mode.
  terminal = {
    -- Lualine primary terminal-mode section.
    a = { bg = colors.teal, fg = colors.bg },
    -- Lualine secondary terminal-mode section.
    b = { bg = colors.bg_alt, fg = colors.fg },
    -- Lualine filler terminal-mode section.
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  -- Lualine colors for inactive windows.
  inactive = {
    -- Lualine primary inactive-window section.
    a = { bg = colors.gutter, fg = colors.fg_dim },
    -- Lualine secondary inactive-window section.
    b = { bg = colors.bg_alt, fg = colors.fg_dim },
    -- Lualine filler inactive-window section.
    c = { bg = colors.bg, fg = colors.gutter },
  },
}
