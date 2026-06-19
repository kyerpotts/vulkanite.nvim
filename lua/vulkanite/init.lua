local config = require("vulkanite.config")
local theme = require("vulkanite.theme")

local M = {}

M.setup = config.setup

function M.load(opts)
	theme.setup(config.extend(opts))
end

return M
