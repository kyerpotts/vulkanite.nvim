local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter-context"

function M.get(colors, opts)
	return {
		TreesitterContext = { fg = colors.fg, bg = colors.bg_alt },
		TreesitterContextLineNumber = { fg = colors.teal, bg = colors.bg_alt, bold = true },
		TreesitterContextBottom = { underline = true, sp = colors.gutter },
		TreesitterContextSeparator = { fg = colors.gutter },
	}
end

return M
