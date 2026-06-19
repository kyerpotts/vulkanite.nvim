local M = {}

M.url = "https://github.com/saghen/blink.cmp"

function M.get(colors, opts)
	return {
		BlinkCmpMenu = { link = "Pmenu" },
		BlinkCmpMenuBorder = { link = "FloatBorder" },
		BlinkCmpMenuSelection = { link = "PmenuSel" },
		BlinkCmpLabel = { fg = colors.fg },
		BlinkCmpLabelDeprecated = { fg = colors.comment, strikethrough = true },
		BlinkCmpLabelMatch = { fg = colors.accent, bold = true },
		BlinkCmpKind = { fg = colors.purple },
		BlinkCmpSource = { fg = colors.comment },
		BlinkCmpDoc = { link = "NormalFloat" },
		BlinkCmpDocBorder = { link = "FloatBorder" },
		BlinkCmpSignatureHelp = { link = "NormalFloat" },
	}
end

return M
