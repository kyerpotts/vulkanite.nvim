local palette = {
	bg = "#0f1416",
	bg_alt = "#151b1e",
	bg_float = "#151b1e",
	fg = "#f8fdff",
	fg_dim = "#abb2bf",
	comment = "#8e969a",
	gutter = "#5c6370",
	red = "#e05f64",
	orange = "#e08a64",
	yellow = "#8fe0fa",
	green = "#8be086",
	cyan = "#567e96",
	blue = "#8fe0fa",
	teal = "#37868b",
	purple = "#7b78aa",
}

local M = {}

function M.get()
	return vim.deepcopy(palette)
end

return M
