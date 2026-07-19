local M = {}

function M.setup(colors, opts)
  local normal_bg = colors.ui.bg
  if opts.transparent then
    normal_bg = nil
  end

  return {
    -- Default text and background for ordinary editor buffers.
    Normal = { fg = colors.ui.fg, bg = normal_bg },
    -- Default text and background for non-current editor windows.
    NormalNC = { fg = colors.ui.fg_dim, bg = normal_bg },
    -- Default text and background for floating windows.
    NormalFloat = { fg = colors.ui.fg, bg = colors.ui.bg_float },
    -- Border color for floating windows.
    FloatBorder = { fg = colors.ui.border, bg = colors.ui.bg_float },
    -- Title text shown in floating window borders.
    FloatTitle = { fg = colors.accent.primary, bg = colors.ui.bg_float },
    -- Background for columns highlighted by 'colorcolumn'.
    ColorColumn = { bg = colors.ui.bg_alt },
    -- Placeholder text hidden behind conceal syntax.
    Conceal = { fg = colors.accent.primary },
    -- Character under the terminal cursor.
    Cursor = { fg = colors.ui.bg, bg = colors.ui.fg },
    -- Background for the screen column containing the cursor.
    CursorColumn = { bg = colors.ui.bg_alt },
    -- Background for the screen line containing the cursor.
    CursorLine = { bg = colors.ui.bg_alt },
    -- Line number for the screen line containing the cursor.
    CursorLineNr = { fg = colors.accent.primary, bold = true },
    -- Directory names in file-oriented buffers.
    Directory = { fg = colors.accent.primary },
    -- Filler tildes after the end of a buffer.
    EndOfBuffer = { fg = colors.ui.bg },
    -- Error messages printed by Vim commands.
    ErrorMsg = { fg = colors.diagnostic.error, bold = true },
    -- Fold column markers beside folded text.
    FoldColumn = { fg = colors.diagnostic.hint, bg = normal_bg },
    -- Folded text replacement lines.
    Folded = { fg = colors.ui.gutter, bg = colors.ui.bg_alt },
    -- Current match selected by an active search.
    CurSearch = {
      fg = colors.ui.bg_alt,
      bg = colors.diagnostic.warn,
      nocombine = true,
    },
    -- Current incremental-search match.
    IncSearch = { link = "CurSearch" },
    -- Absolute line numbers.
    LineNr = { fg = colors.ui.gutter },
    -- Relative line numbers above the cursor line.
    LineNrAbove = { fg = colors.ui.gutter },
    -- Relative line numbers below the cursor line.
    LineNrBelow = { fg = colors.ui.gutter },
    -- Matching bracket or paired delimiter under the cursor.
    MatchParen = { fg = colors.ui.fg_bright, bg = colors.ui.gutter, bold = true },
    -- Mode and recording messages on the command line.
    ModeMsg = { fg = colors.diagnostic.ok },
    -- Continuation prompts such as -- More --.
    MoreMsg = { fg = colors.diagnostic.ok },
    -- Non-text markers such as listchars and end-of-buffer glyphs.
    NonText = { fg = colors.ui.gutter },
    -- Popup menu body used by completion menus.
    Pmenu = { fg = colors.ui.fg, bg = colors.ui.bg_alt },
    -- Currently selected item in a popup menu.
    PmenuSel = { fg = colors.ui.fg_bright, bg = colors.ui.selection },
    -- Scrollbar track in popup menus.
    PmenuSbar = { bg = colors.ui.bg_alt },
    -- Scrollbar thumb in popup menus.
    PmenuThumb = { bg = colors.ui.gutter },
    -- Prompt text for yes/no and other questions.
    Question = { fg = colors.accent.primary },
    -- Active entry in the quickfix list.
    QuickFixLine = { fg = colors.ui.fg_bright, bg = colors.ui.selection },
    -- Search matches for / and ? commands.
    Search = { fg = colors.ui.bg_alt, bg = colors.accent.match, nocombine = true },
    -- Replacement text during a substitute preview.
    Substitute = { link = "Search" },
    -- Sign column beside line numbers.
    SignColumn = { fg = colors.ui.gutter, bg = normal_bg },
    -- Unprintable and special-key text shown by Vim.
    SpecialKey = { fg = colors.ui.gutter },
    -- Misspelled words.
    SpellBad = { undercurl = true, sp = colors.diagnostic.error },
    -- Spelling words that should start with a capital.
    SpellCap = { undercurl = true, sp = colors.accent.primary },
    -- Spelling words local to another region.
    SpellLocal = { undercurl = true, sp = colors.accent.secondary },
    -- Rare spelling words.
    SpellRare = { undercurl = true, sp = colors.accent.secondary },
    -- Status line for the current window.
    StatusLine = { fg = colors.ui.fg, bg = colors.ui.gutter },
    -- Lowercase alias used by some plugins for the current status line.
    Statusline = { fg = colors.ui.fg, bg = colors.ui.gutter },
    -- Status line for non-current windows.
    StatusLineNC = { fg = colors.ui.fg_dim, bg = colors.ui.bg_alt },
    -- Inactive tab-page labels.
    TabLine = { fg = colors.ui.gutter, bg = colors.ui.bg_alt },
    -- Background fill after tab-page labels.
    TabLineFill = { fg = colors.ui.gutter, bg = colors.ui.bg_alt },
    -- Active tab-page label.
    TabLineSel = { fg = colors.diagnostic.ok, bg = colors.ui.bg_alt },
    -- Titles for buffers, quickfix lists, and plugin headings.
    Title = { fg = colors.accent.primary },
    -- Legacy vertical split separator.
    VertSplit = { link = "WinSeparator" },
    -- Selected text in Visual mode.
    Visual = { fg = colors.ui.fg_bright, bg = colors.ui.selection },
    -- Visual selection when Vim does not own the GUI selection.
    VisualNOS = { fg = colors.ui.fg_bright, bg = colors.ui.selection },
    -- Warning messages printed by Vim commands.
    WarningMsg = { fg = colors.diagnostic.warn },
    -- Whitespace markers shown by listchars.
    Whitespace = { fg = colors.ui.gutter },
    -- Active item in command-line completion wildmenu.
    WildMenu = { fg = colors.ui.fg_bright, bg = colors.ui.selection },
    -- Window separators between splits.
    WinSeparator = { fg = colors.ui.separator },

    -- Source comments and documentation comments.
    Comment = vim.tbl_extend("force", { fg = colors.syntax.comment }, opts.styles.comments),
    -- Constants, enum members, and other fixed values.
    Constant = vim.tbl_extend("force", { fg = colors.syntax.constant }, opts.styles.constants),
    -- String literals.
    String = vim.tbl_extend("force", { fg = colors.syntax.string }, opts.styles.strings),
    -- Character literals.
    Character = { fg = colors.syntax.literal },
    -- Integer literals.
    Number = { fg = colors.syntax.literal },
    -- Boolean literals.
    Boolean = { fg = colors.syntax.literal },
    -- Floating-point literals.
    Float = { fg = colors.syntax.literal },
    -- Variable and identifier names without a more specific group.
    Identifier = { fg = colors.syntax.variable },
    -- Function and method declarations or references.
    Function = vim.tbl_extend("force", { fg = colors.syntax.func }, opts.styles.functions),
    -- General language statements without a more specific group.
    Statement = vim.tbl_extend("force", { fg = colors.syntax.keyword }, opts.styles.keywords),
    -- Conditional keywords such as if, else, and switch.
    Conditional = { link = "Statement" },
    -- Loop keywords such as for, while, and repeat.
    Repeat = { link = "Statement" },
    -- Labels used by goto-like language constructs.
    Label = { fg = colors.accent.match },
    -- Operators and symbolic language punctuation.
    Operator = { fg = colors.syntax.operator },
    -- Reserved keywords without a more specific group.
    Keyword = { link = "Statement" },
    -- Exception-handling keywords and exception syntax.
    Exception = { link = "Statement" },
    -- Preprocessor directives and compiler directives.
    PreProc = { fg = colors.accent.match },
    -- Include, import, and require directives.
    Include = { fg = colors.accent.primary },
    -- Macro definition directives.
    Define = { link = "Statement" },
    -- Text beyond a configured line-length limit.
    TooLong = { fg = colors.diagnostic.warn },
    -- Macro invocations and macro names.
    Macro = { fg = colors.syntax.special },
    -- Preprocessor conditionals such as ifdef and endif.
    PreCondit = { fg = colors.accent.match },
    -- Type names and type annotations.
    Type = vim.tbl_extend("force", { fg = colors.syntax.type }, opts.styles.types),
    -- Storage-class keywords such as static, const, and mut.
    StorageClass = { link = "Statement" },
    -- Structured type keywords and names.
    Structure = { link = "Type" },
    -- Typedef and type-alias declarations.
    Typedef = { link = "Type" },
    -- Special syntax that does not fit another group.
    Special = { fg = colors.syntax.special },
    -- Special characters and escape-like character syntax.
    SpecialChar = { fg = colors.syntax.special },
    -- Markup or language tags.
    Tag = { fg = colors.syntax.tag },
    -- Delimiters such as commas, braces, and parentheses.
    Delimiter = { fg = colors.syntax.punctuation },
    -- Special comments; linked to normal comments.
    SpecialComment = { link = "Comment" },
    -- Debugging statements and debug-only syntax.
    Debug = { fg = colors.diagnostic.info },
    -- Underlined text such as links.
    Underlined = { fg = colors.accent.primary, underline = true },
    -- Ignored syntax that should recede from normal text.
    Ignore = { fg = colors.ui.gutter },
    -- Generic error text from syntax highlighting.
    Error = { fg = colors.diagnostic.error, bold = true },
    -- TODO, FIXME, and similar task annotations.
    Todo = { fg = colors.accent.match, bg = colors.ui.bg_alt, bold = true },

    -- Diagnostic error text from Neovim diagnostics.
    DiagnosticError = { fg = colors.diagnostic.error },
    -- Diagnostic warning text from Neovim diagnostics.
    DiagnosticWarn = { fg = colors.diagnostic.warn },
    -- Diagnostic informational text from Neovim diagnostics.
    DiagnosticInfo = { fg = colors.diagnostic.info },
    -- Diagnostic hint text from Neovim diagnostics.
    DiagnosticHint = { fg = colors.diagnostic.hint },
    -- Diagnostic success text from Neovim diagnostics.
    DiagnosticOk = { fg = colors.diagnostic.ok },
    -- Undercurl for ranges covered by error diagnostics.
    DiagnosticUnderlineError = { undercurl = true, sp = colors.diagnostic.error },
    -- Undercurl for ranges covered by warning diagnostics.
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.diagnostic.warn },
    -- Undercurl for ranges covered by informational diagnostics.
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.diagnostic.info },
    -- Undercurl for ranges covered by hint diagnostics.
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.diagnostic.hint },
    -- Undercurl for ranges covered by success diagnostics.
    DiagnosticUnderlineOk = { undercurl = true, sp = colors.diagnostic.ok },
    -- Inline virtual text attached to error diagnostics.
    DiagnosticVirtualTextError = { fg = colors.diagnostic.error, bg = colors.ui.bg_alt },
    -- Inline virtual text attached to warning diagnostics.
    DiagnosticVirtualTextWarn = { fg = colors.diagnostic.warn, bg = colors.ui.bg_alt },
    -- Inline virtual text attached to informational diagnostics.
    DiagnosticVirtualTextInfo = { fg = colors.diagnostic.info, bg = colors.ui.bg_alt },
    -- Inline virtual text attached to hint diagnostics.
    DiagnosticVirtualTextHint = { fg = colors.diagnostic.hint, bg = colors.ui.bg_alt },
    -- Inline virtual text attached to success diagnostics.
    DiagnosticVirtualTextOk = { fg = colors.diagnostic.ok, bg = colors.ui.bg_alt },
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
    DiffAdd = { fg = colors.diff.add, bg = colors.ui.bg_alt },
    -- Changed lines in diffs.
    DiffChange = { fg = colors.diff.change, bg = colors.ui.bg_alt },
    -- Deleted lines in diffs.
    DiffDelete = { fg = colors.diff.delete, bg = colors.ui.bg_alt },
    -- Changed text within a changed diff line.
    DiffText = { fg = colors.ui.fg_bright, bg = colors.ui.gutter, bold = true },
    -- Added text in plugins that use semantic diff groups.
    Added = { fg = colors.diff.add },
    -- Changed text in plugins that use semantic diff groups.
    Changed = { fg = colors.diff.change },
    -- Removed text in plugins that use semantic diff groups.
    Removed = { fg = colors.diff.delete },

    -- Text ranges referenced by LSP document highlights.
    LspReferenceText = { underline = true, sp = colors.accent.primary },
    -- Read-access ranges referenced by LSP document highlights.
    LspReferenceRead = { underline = true, sp = colors.accent.primary },
    -- Write-access ranges referenced by LSP document highlights.
    LspReferenceWrite = { underline = true, sp = colors.accent.primary },
    -- Inline LSP inlay hints.
    LspInlayHint = { fg = colors.ui.gutter, italic = true },
    -- LSP code-lens virtual text.
    LspCodeLens = { fg = colors.ui.comment },
    -- Separator text between LSP code-lens items.
    LspCodeLensSeparator = { fg = colors.ui.gutter },
    -- Active parameter in LSP signature help.
    LspSignatureActiveParameter = { fg = colors.accent.match, underline = true },
  }
end

return M
