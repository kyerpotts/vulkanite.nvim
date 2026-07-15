local M = {}

M.url = "https://github.com/folke/lazy.nvim"

function M.get(colors, opts)
  return {
    -- Lazy.nvim main window body.
    LazyNormal = { link = "NormalFloat" },
    -- Lazy.nvim inactive button.
    LazyButton = { fg = colors.fg, bg = colors.bg_alt },
    -- Lazy.nvim active or selected button.
    LazyButtonActive = { link = "Visual" },
    -- Lazy.nvim primary section heading.
    LazyH1 = { fg = colors.bg, bg = colors.accent, bold = true },
    -- Lazy.nvim secondary section heading.
    LazyH2 = { fg = colors.accent, bold = true },
    -- Lazy.nvim completed progress-bar segment.
    LazyProgressDone = { fg = colors.ok },
    -- Lazy.nvim incomplete progress-bar segment.
    LazyProgressTodo = { fg = colors.gutter },
    -- Lazy.nvim reason text for plugins loaded by plugin dependency.
    LazyReasonPlugin = { fg = colors.hint },
    -- Lazy.nvim property names.
    LazyProp = { fg = colors.teal },
    -- Lazy.nvim property values.
    LazyValue = { fg = colors.value },
    -- Lazy.nvim URLs.
    LazyUrl = { link = "Underlined" },
  }
end

return M
