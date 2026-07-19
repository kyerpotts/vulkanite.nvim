local palette = require("vulkanite.palette")

local M = {}
local current

local function derive_roles(colors)
  local ui = {
    bg = colors.bg,
    bg_alt = colors.bg_alt,
    bg_float = colors.bg_float,
    fg = colors.fg,
    fg_bright = colors.fg_bright,
    fg_dim = colors.fg_dim,
    comment = colors.comment,
    gutter = colors.gutter,
    border = colors.hint,
    separator = colors.gutter,
    selection = colors.selection,
  }
  local syntax = {
    text = colors.fg,
    comment = colors.comment,
    variable = colors.value,
    parameter = colors.value,
    property = colors.fg_bright,
    constant = colors.purple,
    literal = colors.value,
    string = colors.ok,
    documentation = colors.docstring,
    func = colors.accent,
    type = colors.sky_blue,
    keyword = colors.teal,
    operator = colors.fg_bright,
    punctuation = colors.fg_dim,
    special = colors.hint,
    module = colors.value,
    tag = colors.sky_blue,
  }
  local diagnostic = {
    error = colors.error,
    warn = colors.warn,
    info = colors.info,
    hint = colors.hint,
    ok = colors.ok,
  }
  local diff = {
    add = colors.ok,
    change = colors.sky_blue,
    delete = colors.value,
  }
  local accent = {
    primary = colors.accent,
    secondary = colors.bright_teal,
    match = colors.sky_blue,
    icon = colors.purple,
  }

  return {
    ui = ui,
    syntax = syntax,
    diagnostic = diagnostic,
    diff = diff,
    accent = accent,
    integration = {
      bg = ui.bg,
      bg_alt = ui.bg_alt,
      fg = ui.fg,
      fg_dim = ui.fg_dim,
      comment = ui.comment,
      gutter = ui.gutter,
      error = diagnostic.error,
      warn = diagnostic.warn,
      value = syntax.literal,
      info = diagnostic.info,
      hint = diagnostic.hint,
      ok = diagnostic.ok,
      accent = accent.primary,
      accent_secondary = accent.secondary,
      match = accent.match,
      icon = accent.icon,
      rainbow = colors.rainbow,
    },
  }
end

local function resolve(opts, apply_overrides)
  local p = palette.get()
  local colors = {
    bg = p.dark_black,
    bg_alt = p.soft_black,
    bg_float = p.soft_black,
    fg = p.pale_grey,
    fg_bright = p.pale_grey,
    fg_dim = p.light_grey,
    comment = p.comment_grey,
    gutter = p.slate_grey,
    error = p.vivid_red,
    warn = p.yellow,
    value = p.coral_red,
    docstring = p.yellow,
    info = p.bright_blue,
    hint = p.muted_blue,
    selection = p.slate_grey,
    ok = p.bright_green,
    accent = p.bright_blue,
    sky_blue = p.sky_blue,
    purple = p.purple,
    teal = p.dark_teal,
    bright_teal = p.bright_teal,
    terminal = {
      p.dark_black,
      p.coral_red,
      p.bright_green,
      p.yellow,
      p.bright_blue,
      p.purple,
      p.dark_teal,
      p.pale_grey,
      p.slate_grey,
      p.vivid_red,
      p.bright_green,
      p.yellow,
      p.muted_blue,
      p.purple,
      p.bright_teal,
      p.pale_grey,
    },
  }

  if apply_overrides then
    opts.on_colors(colors)
  end
  colors.roles = derive_roles(colors)
  return colors
end

function M.setup(opts)
  opts = require("vulkanite.config").extend(opts)
  current = resolve(opts, true)
  return vim.deepcopy(current)
end

function M.get(opts)
  if current then
    return vim.deepcopy(current)
  end
  return resolve(require("vulkanite.config").extend(opts), false)
end

return M
