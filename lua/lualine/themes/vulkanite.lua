local opts = require("vulkanite.config").extend()
local roles = require("vulkanite.colors").get(opts).roles
local ui = roles.ui
local diagnostic = roles.diagnostic
local syntax = roles.syntax
local accent = roles.accent

return {
  -- Lualine colors when Neovim is in normal mode.
  normal = {
    -- Lualine primary normal-mode section.
    a = { bg = accent.primary, fg = ui.bg },
    -- Lualine secondary normal-mode section.
    b = { bg = ui.bg_alt, fg = ui.fg },
    -- Lualine filler normal-mode section.
    c = { bg = ui.bg, fg = ui.fg_dim },
  },
  -- Lualine colors when Neovim is in insert mode.
  insert = {
    -- Lualine primary insert-mode section.
    a = { bg = diagnostic.ok, fg = ui.bg },
    -- Lualine secondary insert-mode section.
    b = { bg = ui.bg_alt, fg = ui.fg },
    -- Lualine filler insert-mode section.
    c = { bg = ui.bg, fg = ui.fg_dim },
  },
  -- Lualine colors when Neovim is in command-line mode.
  command = {
    -- Lualine primary command-mode section.
    a = { bg = accent.match, fg = ui.bg },
    -- Lualine secondary command-mode section.
    b = { bg = ui.bg_alt, fg = ui.fg },
    -- Lualine filler command-mode section.
    c = { bg = ui.bg, fg = ui.fg_dim },
  },
  -- Lualine colors when Neovim is in visual mode.
  visual = {
    -- Lualine primary visual-mode section.
    a = { bg = accent.icon, fg = ui.bg },
    -- Lualine secondary visual-mode section.
    b = { bg = ui.bg_alt, fg = ui.fg },
    -- Lualine filler visual-mode section.
    c = { bg = ui.bg, fg = ui.fg_dim },
  },
  -- Lualine colors when Neovim is in replace mode.
  replace = {
    -- Lualine primary replace-mode section.
    a = { bg = syntax.literal, fg = ui.bg },
    -- Lualine secondary replace-mode section.
    b = { bg = ui.bg_alt, fg = ui.fg },
    -- Lualine filler replace-mode section.
    c = { bg = ui.bg, fg = ui.fg_dim },
  },
  -- Lualine colors when Neovim is in terminal mode.
  terminal = {
    -- Lualine primary terminal-mode section.
    a = { bg = accent.secondary, fg = ui.bg },
    -- Lualine secondary terminal-mode section.
    b = { bg = ui.bg_alt, fg = ui.fg },
    -- Lualine filler terminal-mode section.
    c = { bg = ui.bg, fg = ui.fg_dim },
  },
  -- Lualine colors for inactive windows.
  inactive = {
    -- Lualine primary inactive-window section.
    a = { bg = ui.bg_alt, fg = ui.fg_dim },
    -- Lualine secondary inactive-window section.
    b = { bg = ui.bg_alt, fg = ui.fg_dim },
    -- Lualine filler inactive-window section.
    c = { bg = ui.bg, fg = ui.gutter },
  },
}
