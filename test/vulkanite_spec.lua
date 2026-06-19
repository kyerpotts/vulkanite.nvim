local function assert_eq(expected, actual, message)
	if actual ~= expected then
		error(string.format("%s\nexpected: %s\nactual: %s", message or "values are not equal", vim.inspect(expected), vim.inspect(actual)), 2)
	end
end

local function assert_truthy(value, message)
	if not value then
		error(message or "expected truthy value", 2)
	end
end

local function reset_vulkanite()
	package.loaded["vulkanite"] = nil
	package.loaded["vulkanite.palette"] = nil
	vim.g.colors_name = nil
	vim.cmd("highlight clear Normal")
	vim.cmd("highlight clear DiagnosticError")
end

reset_vulkanite()

local vulkanite = require("vulkanite")
assert_truthy(vulkanite, "vulkanite module should load")
assert_eq("function", type(vulkanite.setup), "vulkanite.setup should exist")
assert_eq("function", type(vulkanite.load), "vulkanite.load should exist")

local palette = require("vulkanite.palette")
assert_eq("function", type(palette.get), "vulkanite.palette.get should exist")

vulkanite.setup({})
vulkanite.load()
vim.cmd.colorscheme("vulkanite")

assert_eq("vulkanite", vim.g.colors_name, "colorscheme should set colors_name")

local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert_truthy(normal.fg, "Normal fg should exist")

local diagnostic_error = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false })
assert_truthy(diagnostic_error.fg, "DiagnosticError fg should exist")
