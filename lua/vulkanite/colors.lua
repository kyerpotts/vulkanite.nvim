local palette = require("vulkanite.palette")

local M = {}

function M.setup(opts)
  opts = require("vulkanite.config").extend(opts)

  local p = palette.get()
  local colors = {
    bg = p.bg,
    bg_alt = p.bg_alt,
    bg_float = p.bg_float,
    fg = p.fg,
    fg_dim = p.fg_dim,
    comment = p.comment,
    gutter = p.gutter,
    error = p.red,
    warn = p.orange,
    info = p.blue,
    hint = p.cyan,
    ok = p.green,
    accent = p.blue,
    yellow = p.yellow,
    purple = p.purple,
    teal = p.teal,
    terminal = {
      p.bg,
      p.red,
      p.green,
      p.yellow,
      p.blue,
      p.purple,
      p.cyan,
      p.fg,
      p.gutter,
      p.red,
      p.green,
      p.yellow,
      p.blue,
      p.purple,
      p.cyan,
      p.fg,
    },
  }

  opts.on_colors(colors)

  return colors
end

return M
