local function assert_eq(actual, expected, message)
	if actual ~= expected then
		error((message or "assertion failed") .. ": expected " .. vim.inspect(expected) .. ", got " .. vim.inspect(actual), 2)
	end
end

local function assert_truthy(value, message)
	if not value then
		error(message or "expected truthy value", 2)
	end
end

local function reset_vulkanite()
	for name in pairs(package.loaded) do
		if name == "vulkanite" or name:match("^vulkanite%.") then
			package.loaded[name] = nil
		end
	end
	vim.g.colors_name = nil
	for i = 0, 15 do
		vim.g["terminal_color_" .. i] = nil
	end
end

local function run()
	reset_vulkanite()
	local vulkanite = require("vulkanite")
	assert_truthy(vulkanite, "vulkanite module should load")
	assert_eq(type(vulkanite.setup), "function", "setup exists")
	assert_eq(type(vulkanite.load), "function", "load exists")
	assert_eq(type(require("vulkanite.palette").get), "function", "palette get exists")

	vulkanite.setup({})
	vim.cmd.colorscheme("vulkanite")
	assert_eq(vim.g.colors_name, "vulkanite", "colorscheme name")
	assert_truthy(vim.api.nvim_get_hl(0, { name = "Normal" }).fg, "Normal fg set")
	assert_truthy(vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg, "DiagnosticError fg set")

	reset_vulkanite()
	require("vulkanite").load({ terminal_colors = false })
	assert_eq(vim.g.terminal_color_0, nil, "terminal colors stay unset when disabled")

	reset_vulkanite()
	require("vulkanite").load({ transparent = true })
	assert_eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, nil, "transparent Normal background")

	reset_vulkanite()
	require("vulkanite").load({
		on_colors = function(colors)
			colors.error = "#ff0000"
		end,
		on_highlights = function(groups, colors)
			groups.VulkaniteOverrideProbe = { fg = colors.error }
		end,
	})
	assert_eq(vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg, 0xff0000, "on_colors mutates error")
	assert_eq(vim.api.nvim_get_hl(0, { name = "VulkaniteOverrideProbe" }).fg, 0xff0000, "on_highlights sees colors")
end

local ok, err = xpcall(run, debug.traceback)
if not ok then
	vim.api.nvim_err_writeln(err)
	vim.cmd.cquit(1)
end
