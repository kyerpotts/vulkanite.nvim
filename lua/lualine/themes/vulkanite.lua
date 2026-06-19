local opts = require("vulkanite.config").extend()
local colors = require("vulkanite.colors").setup(opts)

return {
  normal = {
    a = { bg = colors.accent, fg = colors.bg },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  insert = {
    a = { bg = colors.ok, fg = colors.bg },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  command = {
    a = { bg = colors.warn, fg = colors.bg },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.bg },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  replace = {
    a = { bg = colors.error, fg = colors.bg },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  terminal = {
    a = { bg = colors.teal, fg = colors.bg },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_dim },
  },
  inactive = {
    a = { bg = colors.gutter, fg = colors.fg_dim },
    b = { bg = colors.bg_alt, fg = colors.fg_dim },
    c = { bg = colors.bg, fg = colors.gutter },
  },
}
