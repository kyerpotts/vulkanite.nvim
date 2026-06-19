local M = {}

M.url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"

function M.get(colors, opts)
	return {
		RenderMarkdownH1 = { fg = colors.accent, bold = true },
		RenderMarkdownH2 = { fg = colors.purple, bold = true },
		RenderMarkdownH3 = { fg = colors.teal, bold = true },
		RenderMarkdownH4 = { fg = colors.ok, bold = true },
		RenderMarkdownH5 = { fg = colors.warn, bold = true },
		RenderMarkdownH6 = { fg = colors.error, bold = true },
		RenderMarkdownCode = { bg = colors.bg_alt },
		RenderMarkdownCodeInline = { fg = colors.yellow, bg = colors.bg_alt },
		RenderMarkdownDash = { fg = colors.comment },
		RenderMarkdownBullet = { fg = colors.accent },
		RenderMarkdownQuote = { fg = colors.comment },
		RenderMarkdownTableHead = { fg = colors.accent, bold = true },
		RenderMarkdownTableRow = { fg = colors.gutter },
	}
end

return M
