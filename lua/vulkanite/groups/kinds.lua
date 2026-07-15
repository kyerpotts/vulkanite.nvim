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
    -- Completion kind text label.
    Text = colors.fg,
    -- Completion kind method icon.
    Method = colors.accent,
    -- Completion kind function icon.
    Function = colors.accent,
    -- Completion kind constructor icon.
    Constructor = colors.teal,
    -- Completion kind field icon.
    Field = colors.fg,
    -- Completion kind variable icon.
    Variable = colors.fg,
    -- Completion kind class icon.
    Class = colors.teal,
    -- Completion kind interface icon.
    Interface = colors.teal,
    -- Completion kind module icon.
    Module = colors.yellow,
    -- Completion kind property icon.
    Property = colors.fg,
    -- Completion kind unit icon.
    Unit = colors.value,
    -- Completion kind value icon.
    Value = colors.value,
    -- Completion kind enum icon.
    Enum = colors.teal,
    -- Completion kind keyword icon.
    Keyword = colors.purple,
    -- Completion kind snippet icon.
    Snippet = colors.purple,
    -- Completion kind color icon.
    Color = colors.value,
    -- Completion kind file icon.
    File = colors.accent,
    -- Completion kind reference icon.
    Reference = colors.info,
    -- Completion kind folder icon.
    Folder = colors.accent,
    -- Completion kind enum-member icon.
    EnumMember = colors.value,
    -- Completion kind constant icon.
    Constant = colors.value,
    -- Completion kind struct icon.
    Struct = colors.teal,
    -- Completion kind event icon.
    Event = colors.yellow,
    -- Completion kind operator icon.
    Operator = colors.fg_dim,
    -- Completion kind type-parameter icon.
    TypeParameter = colors.teal,
  }

  for _, kind in ipairs(kinds) do
    -- Generated completion kind highlight group for the requested plugin pattern.
    ret[string.format(pattern, kind)] = { fg = palette[kind] }
  end

  return ret
end

return M
