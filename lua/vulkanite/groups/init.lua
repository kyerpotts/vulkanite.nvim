local M = {}

function M.setup(colors, opts)
	local bg = opts.transparent and "NONE" or colors.bg

	return {
		Normal = { fg = colors.fg, bg = bg },
		DiagnosticError = { fg = colors.error },
	}
end

return M
