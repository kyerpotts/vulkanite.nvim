local M = {}

M.url = "https://github.com/folke/lazy.nvim"

function M.get(colors, opts)
  return {
    LazyNormal = { link = "NormalFloat" },
    LazyButton = { fg = colors.fg, bg = colors.bg_alt },
    LazyButtonActive = { link = "Visual" },
    LazyH1 = { fg = colors.bg, bg = colors.accent, bold = true },
    LazyH2 = { fg = colors.accent, bold = true },
    LazyProgressDone = { fg = colors.ok },
    LazyProgressTodo = { fg = colors.gutter },
    LazyReasonPlugin = { fg = colors.purple },
    LazyProp = { fg = colors.teal },
    LazyValue = { fg = colors.warn },
    LazyUrl = { link = "Underlined" },
  }
end

return M
