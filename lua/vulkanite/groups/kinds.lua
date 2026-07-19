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
    Text = colors.syntax.text,
    -- Completion kind method icon.
    Method = colors.syntax.func,
    -- Completion kind function icon.
    Function = colors.syntax.func,
    -- Completion kind constructor icon.
    Constructor = colors.syntax.type,
    -- Completion kind field icon.
    Field = colors.syntax.property,
    -- Completion kind variable icon.
    Variable = colors.syntax.variable,
    -- Completion kind class icon.
    Class = colors.syntax.type,
    -- Completion kind interface icon.
    Interface = colors.syntax.type,
    -- Completion kind module icon.
    Module = colors.syntax.module,
    -- Completion kind property icon.
    Property = colors.syntax.property,
    -- Completion kind unit icon.
    Unit = colors.syntax.literal,
    -- Completion kind value icon.
    Value = colors.syntax.literal,
    -- Completion kind enum icon.
    Enum = colors.syntax.type,
    -- Completion kind keyword icon.
    Keyword = colors.accent.icon,
    -- Completion kind snippet icon.
    Snippet = colors.accent.icon,
    -- Completion kind color icon.
    Color = colors.syntax.literal,
    -- Completion kind file icon.
    File = colors.accent.primary,
    -- Completion kind reference icon.
    Reference = colors.diagnostic.info,
    -- Completion kind folder icon.
    Folder = colors.accent.primary,
    -- Completion kind enum-member icon.
    EnumMember = colors.syntax.constant,
    -- Completion kind constant icon.
    Constant = colors.syntax.constant,
    -- Completion kind struct icon.
    Struct = colors.syntax.type,
    -- Completion kind event icon.
    Event = colors.syntax.special,
    -- Completion kind operator icon.
    Operator = colors.syntax.operator,
    -- Completion kind type-parameter icon.
    TypeParameter = colors.syntax.type,
  }

  for _, kind in ipairs(kinds) do
    -- Generated completion kind highlight group for the requested plugin pattern.
    ret[string.format(pattern, kind)] = { fg = palette[kind] }
  end

  return ret
end

return M
