local M = {}

function M.setup(colors, opts)
  return {
    -- LSP semantic token for functions.
    ["@lsp.type.function"] = { link = "Function" },
    -- LSP semantic token for methods.
    ["@lsp.type.method"] = { link = "Function" },
    -- LSP semantic token for variables.
    ["@lsp.type.variable"] = { link = "@variable" },
    -- LSP semantic token for parameters.
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    -- LSP semantic token for properties.
    ["@lsp.type.property"] = { link = "@property" },
    -- LSP semantic token for type names.
    ["@lsp.type.type"] = { link = "Type" },
    -- LSP semantic token for classes.
    ["@lsp.type.class"] = { link = "Type" },
    -- LSP semantic token for structs.
    ["@lsp.type.struct"] = { link = "Type" },
    -- LSP semantic token for interfaces.
    ["@lsp.type.interface"] = { link = "Type" },
    -- LSP semantic token for enums.
    ["@lsp.type.enum"] = { link = "Type" },
    -- LSP semantic token for enum members.
    ["@lsp.type.enumMember"] = { link = "Constant" },
    -- LSP semantic token for namespaces.
    ["@lsp.type.namespace"] = { link = "@module" },
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
    ["@lsp.type.decorator"] = { link = "Special" },
    -- LSP semantic token for macros.
    ["@lsp.type.macro"] = { link = "Macro" },
    -- LSP semantic token for modifiers.
    ["@lsp.type.modifier"] = { link = "Keyword" },
    -- LSP semantic token for regular expressions.
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    -- LSP semantic token for generic type parameters.
    ["@lsp.type.typeParameter"] = { link = "Type" },

    -- Deprecation changes presentation; readonly and default-library modifiers preserve it.
    ["@lsp.mod.deprecated"] = { strikethrough = true },

    -- Combined captures link back to the corresponding syntax role.
    ["@lsp.typemod.variable.readonly"] = { link = "@variable" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.parameter.readonly"] = { link = "@variable.parameter" },
    ["@lsp.typemod.property.readonly"] = { link = "@property" },
    ["@lsp.typemod.property.defaultLibrary"] = { link = "@property" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "Function" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "Function" },
    ["@lsp.typemod.class.defaultLibrary"] = { link = "Type" },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "Type" },
    ["@lsp.typemod.namespace.defaultLibrary"] = { link = "@module.builtin" },
    ["@lsp.typemod.enumMember.readonly"] = { link = "Constant" },
  }
end

return M
