local M = {}

function M.setup(colors, opts)
	local bg = colors.bg
	if opts.transparent then
		bg = nil
	end

	return {
		Normal = { fg = colors.fg, bg = bg },
		DiagnosticError = { fg = colors.error },
	}
end

return M
