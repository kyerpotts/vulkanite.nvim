local M = {}

local kinds = {
  "Text",
  "Method",
  "Function",
  "Constructor",
  "Field",
  "Variable",
  "Class",
  "Interface",
  "Module",
  "Property",
  "Unit",
  "Value",
  "Enum",
  "Keyword",
  "Snippet",
  "Color",
  "File",
  "Reference",
  "Folder",
  "EnumMember",
  "Constant",
  "Struct",
  "Event",
  "Operator",
  "TypeParameter",
}

function M.kinds(ret, pattern, colors)
  local palette = {
    Text = colors.fg,
    Method = colors.accent,
    Function = colors.accent,
    Constructor = colors.teal,
    Field = colors.fg,
    Variable = colors.fg,
    Class = colors.teal,
    Interface = colors.teal,
    Module = colors.yellow,
    Property = colors.fg,
    Unit = colors.warn,
    Value = colors.warn,
    Enum = colors.teal,
    Keyword = colors.purple,
    Snippet = colors.purple,
    Color = colors.warn,
    File = colors.accent,
    Reference = colors.info,
    Folder = colors.accent,
    EnumMember = colors.warn,
    Constant = colors.warn,
    Struct = colors.teal,
    Event = colors.yellow,
    Operator = colors.fg_dim,
    TypeParameter = colors.teal,
  }

  for _, kind in ipairs(kinds) do
    ret[string.format(pattern, kind)] = { fg = palette[kind] }
  end

  return ret
end

return M
