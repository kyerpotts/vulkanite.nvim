local base = require("vulkanite.groups.base")
local kinds = require("vulkanite.groups.kinds")
local semantic_tokens = require("vulkanite.groups.semantic_tokens")
local treesitter = require("vulkanite.groups.treesitter")

local integrations = {
	{
		key = "gitsigns",
		module = "vulkanite.groups.integrations.gitsigns",
		repos = { "lewis6991/gitsigns.nvim", "gitsigns.nvim" },
	},
	{
		key = "telescope",
		module = "vulkanite.groups.integrations.telescope",
		repos = { "nvim-telescope/telescope.nvim", "telescope.nvim" },
	},
	{
		key = "cmp",
		module = "vulkanite.groups.integrations.cmp",
		repos = { "hrsh7th/nvim-cmp", "nvim-cmp" },
	},
	{
		key = "blink",
		module = "vulkanite.groups.integrations.blink",
		repos = { "saghen/blink.cmp", "blink.cmp" },
	},
	{
		key = "which_key",
		module = "vulkanite.groups.integrations.which_key",
		repos = { "folke/which-key.nvim", "which-key.nvim" },
	},
	{
		key = "lazy",
		module = "vulkanite.groups.integrations.lazy",
		repos = { "folke/lazy.nvim", "lazy.nvim" },
	},
	{
		key = "neo_tree",
		module = "vulkanite.groups.integrations.neo_tree",
		repos = { "nvim-neo-tree/neo-tree.nvim", "neo-tree.nvim" },
	},
	{
		key = "nvim_tree",
		module = "vulkanite.groups.integrations.nvim_tree",
		repos = { "nvim-tree/nvim-tree.lua", "nvim-tree.lua" },
	},
	{
		key = "noice",
		module = "vulkanite.groups.integrations.noice",
		repos = { "folke/noice.nvim", "noice.nvim" },
	},
	{
		key = "notify",
		module = "vulkanite.groups.integrations.notify",
		repos = { "rcarriga/nvim-notify", "nvim-notify" },
	},
	{
		key = "snacks",
		module = "vulkanite.groups.integrations.snacks",
		repos = { "folke/snacks.nvim", "snacks.nvim" },
	},
	{
		key = "treesitter_context",
		module = "vulkanite.groups.integrations.treesitter_context",
		repos = { "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter-context" },
	},
	{
		key = "render_markdown",
		module = "vulkanite.groups.integrations.render_markdown",
		repos = { "MeanderingProgrammer/render-markdown.nvim", "render-markdown.nvim" },
	},
}

local function matches_repo(value, repos)
	if type(value) ~= "string" then
		return false
	end

	local candidate = value:lower()
	for _, repo in ipairs(repos) do
		if candidate:find(repo:lower(), 1, true) then
			return true
		end
	end

	return false
end

local function detect_from_lazy(detected)
	if not package.loaded.lazy then
		return
	end

	local ok, lazy_config = pcall(require, "lazy.core.config")
	if not ok or type(lazy_config) ~= "table" or type(lazy_config.plugins) ~= "table" then
		return
	end

	for name, plugin in pairs(lazy_config.plugins) do
		for _, integration in ipairs(integrations) do
			if matches_repo(name, integration.repos) then
				detected[integration.key] = true
			elseif type(plugin) == "table" then
				if matches_repo(plugin.name, integration.repos)
					or matches_repo(plugin.url, integration.repos)
					or matches_repo(plugin.dir, integration.repos)
					or matches_repo(plugin[1], integration.repos)
				then
					detected[integration.key] = true
				end
			end
		end
	end
end

local function detect_from_pack(detected)
	if type(vim.pack) ~= "table" or type(vim.pack.get) ~= "function" then
		return
	end

	local ok, plugins = pcall(vim.pack.get, nil, { info = false })
	if not ok or type(plugins) ~= "table" then
		return
	end

	for _, plugin in ipairs(plugins) do
		local spec = type(plugin) == "table" and plugin.spec
		if type(spec) == "table" then
			for _, integration in ipairs(integrations) do
				if matches_repo(spec.name, integration.repos) or matches_repo(spec.src, integration.repos) then
					detected[integration.key] = true
				end
			end
		end
	end
end

local function detect_plugins(opts)
	local detected = {}
	local plugins = opts.plugins or {}
	if not plugins.auto then
		return detected
	end

	detect_from_lazy(detected)
	detect_from_pack(detected)
	return detected
end

local function plugin_enabled(plugins, detected, key)
	local value = plugins[key]
	if type(value) == "boolean" then
		return value
	end
	if type(value) == "table" and type(value.enabled) == "boolean" then
		return value.enabled
	end
	if plugins.all then
		return true
	end

	return detected[key] == true
end

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

	local plugins = opts.plugins or {}
	local detected = detect_plugins(opts)
	for _, integration in ipairs(integrations) do
		if plugin_enabled(plugins, detected, integration.key) then
			merge(ret, require(integration.module).get(colors, opts))
		end
	end

	return ret
end

return M
