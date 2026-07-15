local M = {}

function M.setup(colors, opts)
  return {
    -- Tree-sitter comments.
    ["@comment"] = { link = "Comment" },
    -- Tree-sitter documentation comments.
    ["@comment.documentation"] = { link = "Comment" },
    -- Tree-sitter error annotations inside comments.
    ["@comment.error"] = { link = "DiagnosticError" },
    -- Tree-sitter warning annotations inside comments.
    ["@comment.warning"] = { link = "DiagnosticWarn" },
    -- Tree-sitter TODO annotations inside comments.
    ["@comment.todo"] = { link = "Todo" },
    -- Tree-sitter note annotations inside comments.
    ["@comment.note"] = { link = "DiagnosticInfo" },

    -- Tree-sitter constants.
    ["@constant"] = { link = "Constant" },
    -- Tree-sitter built-in constants.
    ["@constant.builtin"] = { link = "Constant" },
    -- Tree-sitter macro constants.
    ["@constant.macro"] = { link = "Macro" },
    -- Tree-sitter string literals.
    ["@string"] = { link = "String" },
    -- Tree-sitter documentation strings.
    ["@string.documentation"] = { link = "String" },
    -- Tree-sitter regular-expression strings.
    ["@string.regexp"] = { fg = colors.hint },
    -- Tree-sitter string escape sequences.
    ["@string.escape"] = { link = "SpecialChar" },
    -- Tree-sitter special strings.
    ["@string.special"] = { link = "Special" },
    -- Tree-sitter symbol-like special strings.
    ["@string.special.symbol"] = { link = "String" },
    -- Tree-sitter URL-like special strings.
    ["@string.special.url"] = { link = "Underlined" },
    -- Tree-sitter character literals.
    ["@character"] = { link = "Character" },
    -- Tree-sitter special character literals.
    ["@character.special"] = { link = "SpecialChar" },
    -- Tree-sitter integer literals.
    ["@number"] = { link = "Number" },
    -- Tree-sitter floating-point literals.
    ["@number.float"] = { link = "Float" },
    -- Tree-sitter boolean literals.
    ["@boolean"] = { link = "Boolean" },

    -- Tree-sitter function definitions and references.
    ["@function"] = { link = "Function" },
    -- Tree-sitter function calls.
    ["@function.call"] = { link = "Function" },
    -- Tree-sitter built-in functions.
    ["@function.builtin"] = { link = "Function" },
    -- Tree-sitter function-like macros.
    ["@function.macro"] = { link = "Macro" },
    -- Tree-sitter method definitions.
    ["@function.method"] = { link = "Function" },
    -- Tree-sitter method calls.
    ["@function.method.call"] = { link = "Function" },
    -- Tree-sitter constructors.
    ["@constructor"] = { fg = colors.accent },
    -- Tree-sitter operators.
    ["@operator"] = { link = "Operator" },

    -- Tree-sitter keywords.
    ["@keyword"] = { link = "Keyword" },
    -- Tree-sitter conditional keywords.
    ["@keyword.conditional"] = { link = "Conditional" },
    -- Tree-sitter coroutine keywords.
    ["@keyword.coroutine"] = { link = "Keyword" },
    -- Tree-sitter debug keywords.
    ["@keyword.debug"] = { link = "Debug" },
    -- Tree-sitter compiler or preprocessor directives.
    ["@keyword.directive"] = { link = "PreProc" },
    -- Tree-sitter definition directives.
    ["@keyword.directive.define"] = { link = "Define" },
    -- Tree-sitter exception keywords.
    ["@keyword.exception"] = { link = "Exception" },
    -- Tree-sitter function-introducing keywords.
    ["@keyword.function"] = { link = "Keyword" },
    -- Tree-sitter import keywords.
    ["@keyword.import"] = { link = "Include" },
    -- Tree-sitter operator-like keywords.
    ["@keyword.operator"] = { link = "Operator" },
    -- Tree-sitter loop keywords.
    ["@keyword.repeat"] = { link = "Repeat" },
    -- Tree-sitter return keywords.
    ["@keyword.return"] = { link = "Statement" },
    -- Tree-sitter storage keywords.
    ["@keyword.storage"] = { link = "StorageClass" },

    -- Tree-sitter brackets and paired delimiters.
    ["@punctuation.bracket"] = { link = "Delimiter" },
    -- Tree-sitter punctuation delimiters.
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    -- Tree-sitter special punctuation.
    ["@punctuation.special"] = { link = "Special" },

    -- Tree-sitter type names.
    ["@type"] = { link = "Type" },
    -- Tree-sitter built-in type names.
    ["@type.builtin"] = { fg = colors.yellow, italic = true },
    -- Tree-sitter type definitions.
    ["@type.definition"] = { link = "Typedef" },
    -- Tree-sitter type qualifiers.
    ["@type.qualifier"] = { link = "Keyword" },
    -- Tree-sitter variables.
    ["@variable"] = vim.tbl_extend("force", { fg = colors.value }, opts.styles.variables),
    -- Tree-sitter built-in variables.
    ["@variable.builtin"] = { fg = colors.value, italic = true },
    -- Tree-sitter object or record members.
    ["@variable.member"] = { fg = colors.fg },
    -- Tree-sitter function parameters.
    ["@variable.parameter"] = { fg = colors.fg },
    -- Tree-sitter properties.
    ["@property"] = { fg = colors.fg },
    -- Tree-sitter modules and namespaces.
    ["@module"] = { fg = colors.value },
    -- Tree-sitter built-in modules and namespaces.
    ["@module.builtin"] = { fg = colors.value, italic = true },
    -- Tree-sitter labels.
    ["@label"] = { link = "Label" },

    -- Tree-sitter markup or language tags.
    ["@tag"] = { fg = colors.value },
    -- Tree-sitter tag attributes.
    ["@tag.attribute"] = { fg = colors.yellow },
    -- Tree-sitter tag delimiters.
    ["@tag.delimiter"] = { fg = colors.teal },

    -- Legacy Tree-sitter namespace capture.
    ["@namespace"] = { link = "@module" },
    -- Legacy Tree-sitter field capture.
    ["@field"] = { link = "@variable.member" },
    -- Legacy Tree-sitter parameter capture.
    ["@parameter"] = { link = "@variable.parameter" },
    -- Legacy Tree-sitter method definition capture.
    ["@method"] = { link = "@function.method" },
    -- Legacy Tree-sitter method call capture.
    ["@method.call"] = { link = "@function.method.call" },
    -- Legacy Tree-sitter plain text capture.
    ["@text"] = { fg = colors.fg },
    -- Legacy Tree-sitter bold text capture.
    ["@text.strong"] = { bold = true },
    -- Legacy Tree-sitter italic text capture.
    ["@text.emphasis"] = { italic = true },
    -- Legacy Tree-sitter underlined text capture.
    ["@text.underline"] = { underline = true },
    -- Legacy Tree-sitter URI text capture.
    ["@text.uri"] = { link = "Underlined" },
  }
end

return M
