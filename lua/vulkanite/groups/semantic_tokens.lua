local M = {}

function M.setup(colors, opts)
  return {
    -- LSP semantic token for functions.
    ["@lsp.type.function"] = { link = "Function" },
    -- LSP semantic token for methods.
    ["@lsp.type.method"] = { link = "Function" },
    -- LSP semantic token for variables.
    ["@lsp.type.variable"] = vim.tbl_extend("force", { fg = colors.fg }, opts.styles.variables),
    -- LSP semantic token for parameters.
    ["@lsp.type.parameter"] = { fg = colors.fg_dim },
    -- LSP semantic token for properties.
    ["@lsp.type.property"] = { fg = colors.fg },
    -- LSP semantic token for type names.
    ["@lsp.type.type"] = { link = "Type" },
    -- LSP semantic token for classes.
    ["@lsp.type.class"] = { link = "Type" },
    -- LSP semantic token for structs.
    ["@lsp.type.struct"] = { link = "Type" },
    -- LSP semantic token for interfaces.
    ["@lsp.type.interface"] = { fg = colors.teal, italic = true },
    -- LSP semantic token for enums.
    ["@lsp.type.enum"] = { link = "Type" },
    -- LSP semantic token for enum members.
    ["@lsp.type.enumMember"] = { link = "Constant" },
    -- LSP semantic token for namespaces.
    ["@lsp.type.namespace"] = { link = "TSNamespace" },
    -- LSP semantic token for keywords.
    ["@lsp.type.keyword"] = { link = "Keyword" },
    -- LSP semantic token for comments.
    ["@lsp.type.comment"] = { link = "Comment" },
    -- LSP semantic token for strings.
    ["@lsp.type.string"] = { link = "String" },
    -- LSP semantic token for numbers.
    ["@lsp.type.number"] = { link = "Number" },
    -- LSP semantic token for operators.
    ["@lsp.type.operator"] = { link = "Operator" },
    -- LSP semantic token for decorators and attributes.
    ["@lsp.type.decorator"] = { fg = colors.teal },
    -- LSP semantic token for macros.
    ["@lsp.type.macro"] = { link = "Macro" },
    -- LSP semantic token for modifiers.
    ["@lsp.type.modifier"] = { link = "Keyword" },
    -- LSP semantic token for regular expressions.
    ["@lsp.type.regexp"] = { fg = colors.teal },
    -- LSP semantic token for generic type parameters.
    ["@lsp.type.typeParameter"] = { fg = colors.teal, italic = true },

    -- LSP readonly modifier applied to any semantic token.
    ["@lsp.mod.readonly"] = { fg = colors.value, italic = true },
    -- LSP default-library modifier applied to any semantic token.
    ["@lsp.mod.defaultLibrary"] = { fg = colors.teal, italic = true },
    -- LSP deprecated modifier applied to any semantic token.
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    -- LSP definition modifier applied to declarations that define symbols.
    ["@lsp.mod.definition"] = { bold = true },
    -- LSP declaration modifier applied to declarations that introduce symbols.
    ["@lsp.mod.declaration"] = { bold = true },
    -- LSP variable token that is readonly.
    ["@lsp.typemod.variable.readonly"] = { fg = colors.value, italic = true },
    -- LSP variable token from the default library.
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = colors.teal, italic = true },
    -- LSP parameter token that is readonly.
    ["@lsp.typemod.parameter.readonly"] = { fg = colors.value, italic = true },
    -- LSP property token that is readonly.
    ["@lsp.typemod.property.readonly"] = { fg = colors.value, italic = true },
    -- LSP property token from the default library.
    ["@lsp.typemod.property.defaultLibrary"] = { fg = colors.teal, italic = true },
    -- LSP function token from the default library.
    ["@lsp.typemod.function.defaultLibrary"] = { link = "Function" },
    -- LSP method token from the default library.
    ["@lsp.typemod.method.defaultLibrary"] = { link = "Function" },
    -- LSP class token from the default library.
    ["@lsp.typemod.class.defaultLibrary"] = { link = "Type" },
    -- LSP type token from the default library.
    ["@lsp.typemod.type.defaultLibrary"] = { link = "Type" },
    -- LSP namespace token from the default library.
    ["@lsp.typemod.namespace.defaultLibrary"] = { fg = colors.teal, italic = true },
    -- LSP enum-member token that is readonly.
    ["@lsp.typemod.enumMember.readonly"] = { fg = colors.value, italic = true },
  }
end

return M
