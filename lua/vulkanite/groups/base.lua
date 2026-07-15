local M = {}

function M.setup(colors, opts)
  local normal_bg = colors.bg
  if opts.transparent then
    normal_bg = nil
  end

  return {
    -- Default text and background for ordinary editor buffers.
    Normal = { fg = colors.fg, bg = normal_bg },
    -- Default text and background for non-current editor windows.
    NormalNC = { fg = colors.fg_dim, bg = normal_bg },
    -- Default text and background for floating windows.
    NormalFloat = { fg = colors.fg, bg = colors.bg_float },
    -- Border color for floating windows.
    FloatBorder = { fg = colors.fg, bg = colors.bg_float },
    -- Title text shown in floating window borders.
    FloatTitle = { fg = colors.accent, bg = colors.bg_float },
    -- Background for columns highlighted by 'colorcolumn'.
    ColorColumn = { bg = colors.bg_alt },
    -- Placeholder text hidden behind conceal syntax.
    Conceal = { fg = colors.accent },
    -- Character under the terminal cursor.
    Cursor = { fg = colors.bg, bg = colors.fg },
    -- Background for the screen column containing the cursor.
    CursorColumn = { bg = colors.bg_alt },
    -- Background for the screen line containing the cursor.
    CursorLine = { bg = colors.bg },
    -- Line number for the screen line containing the cursor.
    CursorLineNr = { fg = colors.fg, bg = colors.bg },
    -- Directory names in file-oriented buffers.
    Directory = { fg = colors.accent },
    -- Filler tildes after the end of a buffer.
    EndOfBuffer = { fg = colors.bg },
    -- Error messages printed by Vim commands.
    ErrorMsg = { fg = colors.error, bold = true },
    -- Fold column markers beside folded text.
    FoldColumn = { fg = colors.hint, bg = normal_bg },
    -- Folded text replacement lines.
    Folded = { fg = colors.gutter, bg = colors.bg_alt },
    -- Current incremental-search match.
    IncSearch = { fg = colors.bg_alt, bg = colors.value },
    -- Absolute line numbers.
    LineNr = { fg = colors.gutter },
    -- Relative line numbers above the cursor line.
    LineNrAbove = { fg = colors.gutter },
    -- Relative line numbers below the cursor line.
    LineNrBelow = { fg = colors.gutter },
    -- Matching bracket or paired delimiter under the cursor.
    MatchParen = { fg = colors.bg, bg = colors.gutter, bold = true },
    -- Mode and recording messages on the command line.
    ModeMsg = { fg = colors.ok },
    -- Continuation prompts such as -- More --.
    MoreMsg = { fg = colors.ok },
    -- Non-text markers such as listchars and end-of-buffer glyphs.
    NonText = { fg = colors.gutter },
    -- Popup menu body used by completion menus.
    Pmenu = { fg = colors.fg, bg = colors.bg_alt },
    -- Currently selected item in a popup menu.
    PmenuSel = { fg = colors.bg, bg = colors.selection },
    -- Scrollbar track in popup menus.
    PmenuSbar = { bg = colors.bg_alt },
    -- Scrollbar thumb in popup menus.
    PmenuThumb = { bg = colors.gutter },
    -- Prompt text for yes/no and other questions.
    Question = { fg = colors.accent },
    -- Active entry in the quickfix list.
    QuickFixLine = { bg = colors.selection },
    -- Search matches for / and ? commands.
    Search = { fg = colors.bg_alt, bg = colors.yellow },
    -- Sign column beside line numbers.
    SignColumn = { fg = colors.gutter, bg = normal_bg },
    -- Unprintable and special-key text shown by Vim.
    SpecialKey = { fg = colors.gutter },
    -- Misspelled words.
    SpellBad = { undercurl = true, sp = colors.error },
    -- Spelling words that should start with a capital.
    SpellCap = { undercurl = true, sp = colors.accent },
    -- Spelling words local to another region.
    SpellLocal = { undercurl = true, sp = colors.teal },
    -- Rare spelling words.
    SpellRare = { undercurl = true, sp = colors.teal },
    -- Status line for the current window.
    StatusLine = { fg = colors.fg, bg = colors.gutter },
    -- Lowercase alias used by some plugins for the current status line.
    Statusline = { fg = colors.fg, bg = colors.gutter },
    -- Status line for non-current windows.
    StatusLineNC = { fg = colors.fg_dim, bg = colors.bg_alt },
    -- Inactive tab-page labels.
    TabLine = { fg = colors.gutter, bg = colors.bg_alt },
    -- Background fill after tab-page labels.
    TabLineFill = { fg = colors.gutter, bg = colors.bg_alt },
    -- Active tab-page label.
    TabLineSel = { fg = colors.ok, bg = colors.bg_alt },
    -- Titles for buffers, quickfix lists, and plugin headings.
    Title = { fg = colors.accent },
    -- Legacy vertical split separator.
    VertSplit = { fg = colors.fg, bg = normal_bg },
    -- Selected text in Visual mode.
    Visual = { fg = colors.bg, bg = colors.selection },
    -- Visual selection when Vim does not own the GUI selection.
    VisualNOS = { fg = colors.bg, bg = colors.selection },
    -- Warning messages printed by Vim commands.
    WarningMsg = { fg = colors.warn },
    -- Whitespace markers shown by listchars.
    Whitespace = { fg = colors.gutter },
    -- Active item in command-line completion wildmenu.
    WildMenu = { fg = colors.value, bg = colors.yellow },
    -- Window separators between splits.
    WinSeparator = { fg = colors.gutter },

    -- Source comments and documentation comments.
    Comment = vim.tbl_extend("force", { fg = colors.comment }, opts.styles.comments),
    -- Constants, enum members, and other fixed values.
    Constant = { fg = colors.value },
    -- String literals.
    String = vim.tbl_extend("force", { fg = colors.ok }, opts.styles.strings),
    -- Character literals.
    Character = { fg = colors.value },
    -- Integer literals.
    Number = { fg = colors.value },
    -- Boolean literals.
    Boolean = { fg = colors.value },
    -- Floating-point literals.
    Float = { fg = colors.value },
    -- Variable and identifier names without a more specific group.
    Identifier = { fg = colors.value },
    -- Function and method declarations or references.
    Function = vim.tbl_extend("force", { fg = colors.accent }, opts.styles.functions),
    -- General language statements without a more specific group.
    Statement = vim.tbl_extend("force", { fg = colors.value }, opts.styles.keywords),
    -- Conditional keywords such as if, else, and switch.
    Conditional = { fg = colors.teal },
    -- Loop keywords such as for, while, and repeat.
    Repeat = { fg = colors.yellow },
    -- Labels used by goto-like language constructs.
    Label = { fg = colors.yellow },
    -- Operators and symbolic language punctuation.
    Operator = { fg = colors.teal },
    -- Reserved keywords without a more specific group.
    Keyword = { fg = colors.teal },
    -- Exception-handling keywords and exception syntax.
    Exception = { fg = colors.error },
    -- Preprocessor directives and compiler directives.
    PreProc = { fg = colors.yellow },
    -- Include, import, and require directives.
    Include = { fg = colors.accent },
    -- Macro definition directives.
    Define = { fg = colors.teal },
    -- Text beyond a configured line-length limit.
    TooLong = { fg = colors.error },
    -- Macro invocations and macro names.
    Macro = { fg = colors.value },
    -- Preprocessor conditionals such as ifdef and endif.
    PreCondit = { fg = colors.yellow },
    -- Type names and type annotations.
    Type = { fg = colors.yellow },
    -- Storage-class keywords such as static, const, and mut.
    StorageClass = { fg = colors.yellow },
    -- Structured type keywords and names.
    Structure = { fg = colors.teal },
    -- Typedef and type-alias declarations.
    Typedef = { fg = colors.yellow },
    -- Special syntax that does not fit another group.
    Special = { fg = colors.hint },
    -- Special characters and escape-like character syntax.
    SpecialChar = { fg = colors.teal },
    -- Markup or language tags.
    Tag = { fg = colors.yellow },
    -- Delimiters such as commas, braces, and parentheses.
    Delimiter = { fg = colors.teal },
    -- Special comments; linked to normal comments.
    SpecialComment = { link = "Comment" },
    -- Debugging statements and debug-only syntax.
    Debug = { fg = colors.value },
    -- Underlined text such as links.
    Underlined = { fg = colors.value, underline = true },
    -- Ignored syntax that should recede from normal text.
    Ignore = { fg = colors.gutter },
    -- Generic error text from syntax highlighting.
    Error = { fg = colors.error, bold = true },
    -- TODO, FIXME, and similar task annotations.
    Todo = { fg = colors.yellow, bg = colors.bg_alt, bold = true },

    -- Diagnostic error text from Neovim diagnostics.
    DiagnosticError = { fg = colors.error },
    -- Diagnostic warning text from Neovim diagnostics.
    DiagnosticWarn = { fg = colors.warn },
    -- Diagnostic informational text from Neovim diagnostics.
    DiagnosticInfo = { fg = colors.info },
    -- Diagnostic hint text from Neovim diagnostics.
    DiagnosticHint = { fg = colors.hint },
    -- Diagnostic success text from Neovim diagnostics.
    DiagnosticOk = { fg = colors.ok },
    -- Undercurl for ranges covered by error diagnostics.
    DiagnosticUnderlineError = { undercurl = true, sp = colors.error },
    -- Undercurl for ranges covered by warning diagnostics.
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.warn },
    -- Undercurl for ranges covered by informational diagnostics.
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.info },
    -- Undercurl for ranges covered by hint diagnostics.
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.hint },
    -- Undercurl for ranges covered by success diagnostics.
    DiagnosticUnderlineOk = { undercurl = true, sp = colors.ok },
    -- Inline virtual text attached to error diagnostics.
    DiagnosticVirtualTextError = { fg = colors.error, bg = colors.bg_alt },
    -- Inline virtual text attached to warning diagnostics.
    DiagnosticVirtualTextWarn = { fg = colors.warn, bg = colors.bg_alt },
    -- Inline virtual text attached to informational diagnostics.
    DiagnosticVirtualTextInfo = { fg = colors.info, bg = colors.bg_alt },
    -- Inline virtual text attached to hint diagnostics.
    DiagnosticVirtualTextHint = { fg = colors.hint, bg = colors.bg_alt },
    -- Inline virtual text attached to success diagnostics.
    DiagnosticVirtualTextOk = { fg = colors.ok, bg = colors.bg_alt },
    -- Floating-window diagnostic errors.
    DiagnosticFloatingError = { link = "DiagnosticError" },
    -- Floating-window diagnostic warnings.
    DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
    -- Floating-window diagnostic informational messages.
    DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
    -- Floating-window diagnostic hints.
    DiagnosticFloatingHint = { link = "DiagnosticHint" },
    -- Floating-window diagnostic success messages.
    DiagnosticFloatingOk = { link = "DiagnosticOk" },
    -- Sign-column marker for error diagnostics.
    DiagnosticSignError = { link = "DiagnosticError" },
    -- Sign-column marker for warning diagnostics.
    DiagnosticSignWarn = { link = "DiagnosticWarn" },
    -- Sign-column marker for informational diagnostics.
    DiagnosticSignInfo = { link = "DiagnosticInfo" },
    -- Sign-column marker for hint diagnostics.
    DiagnosticSignHint = { link = "DiagnosticHint" },
    -- Sign-column marker for success diagnostics.
    DiagnosticSignOk = { link = "DiagnosticOk" },

    -- Added lines in diffs.
    DiffAdd = { fg = colors.ok, bg = colors.bg_alt },
    -- Changed lines in diffs.
    DiffChange = { fg = colors.yellow, bg = colors.bg_alt },
    -- Deleted lines in diffs.
    DiffDelete = { fg = colors.value, bg = colors.bg_alt },
    -- Changed text within a changed diff line.
    DiffText = { fg = colors.info, bg = colors.gutter },
    -- Added text in plugins that use semantic diff groups.
    Added = { fg = colors.ok },
    -- Changed text in plugins that use semantic diff groups.
    Changed = { fg = colors.yellow },
    -- Removed text in plugins that use semantic diff groups.
    Removed = { fg = colors.value },

    TSNamespace = { fg = colors.value },

    -- Text ranges referenced by LSP document highlights.
    -- LspReferenceText = { underline = true, sp = colors.value },
    -- -- Read-access ranges referenced by LSP document highlights.
    -- LspReferenceRead = { underline = true, sp = colors.value },
    -- -- Write-access ranges referenced by LSP document highlights.
    -- LspReferenceWrite = { underline = true, sp = colors.value },
    -- Inline LSP inlay hints.
    LspInlayHint = { fg = colors.gutter, italic = true },
    -- LSP code-lens virtual text.
    LspCodeLens = { fg = colors.comment },
    -- Separator text between LSP code-lens items.
    LspCodeLensSeparator = { fg = colors.gutter },
    -- Active parameter in LSP signature help.
    LspSignatureActiveParameter = { fg = colors.yellow, bold = false },
  }
end

return M
