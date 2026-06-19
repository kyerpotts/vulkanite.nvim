local M = {}

function M.setup(colors, opts)
  return {
    ["@lsp.type.function"] = { link = "Function" },
    ["@lsp.type.method"] = { link = "Function" },
    ["@lsp.type.variable"] = vim.tbl_extend("force", { fg = colors.fg }, opts.styles.variables),
    ["@lsp.type.parameter"] = { fg = colors.fg_dim },
    ["@lsp.type.property"] = { fg = colors.fg },
    ["@lsp.type.type"] = { link = "Type" },
    ["@lsp.type.class"] = { link = "Type" },
    ["@lsp.type.struct"] = { link = "Type" },
    ["@lsp.type.interface"] = { fg = colors.teal, italic = true },
    ["@lsp.type.enum"] = { link = "Type" },
    ["@lsp.type.enumMember"] = { link = "Constant" },
    ["@lsp.type.namespace"] = { fg = colors.yellow },
    ["@lsp.type.keyword"] = { link = "Keyword" },
    ["@lsp.type.comment"] = { link = "Comment" },
    ["@lsp.type.string"] = { link = "String" },
    ["@lsp.type.number"] = { link = "Number" },
    ["@lsp.type.operator"] = { link = "Operator" },
    ["@lsp.type.decorator"] = { fg = colors.teal },
    ["@lsp.type.macro"] = { link = "Macro" },
    ["@lsp.type.modifier"] = { link = "Keyword" },
    ["@lsp.type.regexp"] = { fg = colors.teal },
    ["@lsp.type.typeParameter"] = { fg = colors.teal, italic = true },

    ["@lsp.mod.readonly"] = { fg = colors.value, italic = true },
    ["@lsp.mod.defaultLibrary"] = { fg = colors.teal, italic = true },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.mod.definition"] = { bold = true },
    ["@lsp.mod.declaration"] = { bold = true },
    ["@lsp.typemod.variable.readonly"] = { fg = colors.value, italic = true },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = colors.teal, italic = true },
    ["@lsp.typemod.parameter.readonly"] = { fg = colors.value, italic = true },
    ["@lsp.typemod.property.readonly"] = { fg = colors.value, italic = true },
    ["@lsp.typemod.property.defaultLibrary"] = { fg = colors.teal, italic = true },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "Function" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "Function" },
    ["@lsp.typemod.class.defaultLibrary"] = { link = "Type" },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "Type" },
    ["@lsp.typemod.namespace.defaultLibrary"] = { fg = colors.teal, italic = true },
    ["@lsp.typemod.enumMember.readonly"] = { fg = colors.value, italic = true },
  }
end

return M
