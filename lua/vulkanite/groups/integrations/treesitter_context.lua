local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter-context"

function M.get(colors, opts)
  return {
    -- Treesitter-context sticky context window body.
    TreesitterContext = { fg = colors.fg, bg = colors.bg_alt },
    -- Treesitter-context line number for the sticky context.
    TreesitterContextLineNumber = {
      fg = colors.accent_secondary,
      bg = colors.bg_alt,
      bold = true,
    },
    -- Treesitter-context underline at the bottom of the sticky context.
    TreesitterContextBottom = { underline = true, sp = colors.gutter },
    -- Treesitter-context separator line.
    TreesitterContextSeparator = { fg = colors.gutter },
  }
end

return M
