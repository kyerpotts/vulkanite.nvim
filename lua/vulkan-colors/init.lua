local M = {}

M.palette = require("vulkan-colors.palette")

local function set(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options or {}, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.g.colors_name = "vulkan-colors"
  vim.o.termguicolors = true

  local c = M.palette

  local groups = {
    Normal = { fg = c.base05, bg = c.base00 },
    NormalFloat = { fg = c.base05, bg = c.base01 },
    FloatBorder = { fg = c.base0C, bg = c.base01 },
    ColorColumn = { bg = c.base01 },
    Conceal = { fg = c.base0D },
    Cursor = { fg = c.base00, bg = c.base05 },
    CursorColumn = {},
    CursorLine = {},
    CursorLineNr = { fg = c.base0C, bold = true },
    Directory = { fg = c.base0D },
    EndOfBuffer = { fg = c.base00 },
    ErrorMsg = { fg = c.base08, bold = true },
    FoldColumn = { fg = c.base03, bg = c.base00 },
    Folded = { fg = c.base03, bg = c.base01 },
    IncSearch = { fg = c.base00, bg = c.base09 },
    LineNr = { fg = c.base03 },
    MatchParen = { fg = c.base00, bg = c.base03, bold = true },
    ModeMsg = { fg = c.base0B },
    MoreMsg = { fg = c.base0B },
    NonText = { fg = c.base03 },
    Pmenu = { fg = c.base05, bg = c.base01 },
    PmenuSel = { fg = c.base00, bg = c.base0D },
    PmenuSbar = { bg = c.base02 },
    PmenuThumb = { bg = c.base04 },
    Question = { fg = c.base0D },
    Search = { fg = c.base00, bg = c.base0A },
    SignColumn = { fg = c.base03, bg = c.base00 },
    SpecialKey = { fg = c.base03 },
    SpellBad = { undercurl = true, sp = c.base08 },
    SpellCap = { undercurl = true, sp = c.base0D },
    SpellLocal = { undercurl = true, sp = c.base0C },
    SpellRare = { undercurl = true, sp = c.base0E },
    StatusLine = { fg = c.base0A, bg = c.base00 },
    Statusline = { fg = c.base0A, bg = c.base00 },
    StatusLineNC = { fg = c.base03, bg = c.base01 },
    TabLine = { fg = c.base03, bg = c.base01 },
    TabLineFill = { bg = c.base01 },
    TabLineSel = { fg = c.base0D, bg = c.base00 },
    Title = { fg = c.base0D, bold = true },
    VertSplit = { fg = c.base02 },
    Visual = { fg = c.base05, bg = c.base02, bold = true },
    WarningMsg = { fg = c.base09 },
    WildMenu = { fg = c.base00, bg = c.base0D },

    Comment = { fg = c.comment, italic = true },
    Constant = { fg = c.base09 },
    String = { fg = c.base0B, italic = true },
    Character = { fg = c.base0B },
    Number = { fg = c.base09 },
    Boolean = { fg = c.base09 },
    Float = { fg = c.base09 },
    Identifier = { fg = c.base08 },
    Function = { fg = c.base0D, bold = true },
    Statement = { fg = c.base0E, bold = true },
    Conditional = { link = "Statement" },
    Repeat = { link = "Statement" },
    Label = { fg = c.base0E },
    Operator = { fg = c.base04 },
    Keyword = { link = "Statement" },
    Exception = { fg = c.base08 },
    PreProc = { fg = c.base0A },
    Include = { fg = c.base0D },
    Define = { fg = c.base0E },
    Macro = { fg = c.base0D, italic = true },
    PreCondit = { fg = c.base0A },
    Type = { fg = c.base0C, bold = true, italic = true },
    StorageClass = { fg = c.base0A },
    Structure = { link = "Type" },
    Typedef = { fg = c.base0A },
    Special = { fg = c.base0C },
    SpecialChar = { fg = c.base0F },
    Tag = { fg = c.base0A },
    Delimiter = { fg = c.base04 },
    SpecialComment = { fg = c.comment, italic = true },
    Debug = { fg = c.base08 },
    Underlined = { fg = c.base0D, underline = true },
    Ignore = { fg = c.base03 },
    Error = { fg = c.base08, bold = true },
    Todo = { fg = c.base0A, bg = c.base01, bold = true },

    DiagnosticError = { fg = c.base08 },
    DiagnosticWarn = { fg = c.base09 },
    DiagnosticInfo = { fg = c.base0D },
    DiagnosticHint = { fg = c.base0C },
    DiagnosticOk = { fg = c.base0B },
    DiagnosticUnderlineError = { undercurl = true, sp = c.base08 },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.base09 },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.base0D },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.base0C },

    DiffAdd = { fg = c.base0B, bg = c.base01 },
    DiffChange = { fg = c.base0A, bg = c.base01 },
    DiffDelete = { fg = c.base08, bg = c.base01 },
    DiffText = { fg = c.base0D, bg = c.base02 },

    GitSignsAdd = { fg = c.base0B },
    GitSignsChange = { fg = c.base0A },
    GitSignsDelete = { fg = c.base08 },

    TelescopeBorder = { fg = c.base0C, bg = c.base00 },
    TelescopeNormal = { fg = c.base05, bg = c.base00 },
    TelescopeSelection = { fg = c.base05, bg = c.base01, bold = true },
    TelescopeMatching = { fg = c.base0A, bold = true },

    TreesitterContext = { bg = c.base01 },
    TreesitterContextLineNumber = { fg = c.base0C, bg = c.base01 },

    ["@comment"] = { link = "Comment" },
    ["@constant"] = { link = "Constant" },
    ["@string"] = { link = "String" },
    ["@number"] = { link = "Number" },
    ["@boolean"] = { link = "Boolean" },
    ["@function"] = { link = "Function" },
    ["@function.call"] = { link = "Function" },
    ["@function.macro"] = { link = "Macro" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@keyword.return"] = { link = "Statement" },
    ["@operator"] = { link = "Operator" },
    ["@punctuation.bracket"] = { link = "Delimiter" },
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@type"] = { link = "Type" },
    ["@variable"] = { fg = c.base05 },
    ["@variable.builtin"] = { fg = c.base08 },
    ["@property"] = { fg = c.base05 },
    ["@field"] = { fg = c.base05 },
    ["@constructor"] = { fg = c.base0C },
    ["@tag"] = { fg = c.base0A },
    ["@tag.attribute"] = { fg = c.base0D },
    ["@tag.delimiter"] = { fg = c.base04 },
  }

  for group, opts in pairs(groups) do
    set(group, opts)
  end

  vim.g.terminal_color_0 = c.base00
  vim.g.terminal_color_1 = c.base08
  vim.g.terminal_color_2 = c.base0B
  vim.g.terminal_color_3 = c.base0A
  vim.g.terminal_color_4 = c.base0D
  vim.g.terminal_color_5 = c.base0E
  vim.g.terminal_color_6 = c.base0C
  vim.g.terminal_color_7 = c.base05
  vim.g.terminal_color_8 = c.base03
  vim.g.terminal_color_9 = c.base08
  vim.g.terminal_color_10 = c.base0B
  vim.g.terminal_color_11 = c.base0A
  vim.g.terminal_color_12 = c.base0D
  vim.g.terminal_color_13 = c.base0E
  vim.g.terminal_color_14 = c.base0C
  vim.g.terminal_color_15 = c.base07
end

return M
