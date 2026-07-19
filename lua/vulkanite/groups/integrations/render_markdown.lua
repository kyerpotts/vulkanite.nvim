local M = {}

M.url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"

function M.get(colors, opts)
  return {
    -- Render-markdown level-one heading.
    RenderMarkdownH1 = { fg = colors.accent, bold = true },
    -- Render-markdown level-two heading.
    RenderMarkdownH2 = { fg = colors.accent, bold = true },
    -- Render-markdown level-three heading.
    RenderMarkdownH3 = { fg = colors.accent_secondary, bold = true },
    -- Render-markdown level-four heading.
    RenderMarkdownH4 = { fg = colors.ok, bold = true },
    -- Render-markdown level-five heading.
    RenderMarkdownH5 = { fg = colors.hint, bold = true },
    -- Render-markdown level-six heading.
    RenderMarkdownH6 = { fg = colors.value, bold = true },
    -- Render-markdown fenced code block background.
    RenderMarkdownCode = { bg = colors.bg_alt },
    -- Render-markdown inline code span.
    RenderMarkdownCodeInline = { fg = colors.match, bg = colors.bg_alt },
    -- Render-markdown horizontal rule dash.
    RenderMarkdownDash = { fg = colors.comment },
    -- Render-markdown list bullet.
    RenderMarkdownBullet = { fg = colors.accent },
    -- Render-markdown blockquote marker.
    RenderMarkdownQuote = { fg = colors.comment },
    -- Render-markdown table header row.
    RenderMarkdownTableHead = { fg = colors.accent, bold = true },
    -- Render-markdown table body row.
    RenderMarkdownTableRow = { fg = colors.gutter },
  }
end

return M
