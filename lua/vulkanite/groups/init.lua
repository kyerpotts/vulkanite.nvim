local base = require("vulkanite.groups.base")
local kinds = require("vulkanite.groups.kinds")
local semantic_tokens = require("vulkanite.groups.semantic_tokens")
local treesitter = require("vulkanite.groups.treesitter")

local M = {}

local function merge(ret, groups)
	for name, highlight in pairs(groups) do
		ret[name] = highlight
	end
end

function M.setup(colors, opts)
	local ret = {}

	merge(ret, base.setup(colors, opts))
	merge(ret, treesitter.setup(colors, opts))
	merge(ret, semantic_tokens.setup(colors, opts))
	kinds.kinds(ret, "LspKind%s", colors)

	return ret
end

return M
