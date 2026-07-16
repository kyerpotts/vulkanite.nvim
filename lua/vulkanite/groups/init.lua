local base = require("vulkanite.groups.base")
local kinds = require("vulkanite.groups.kinds")
local semantic_tokens = require("vulkanite.groups.semantic_tokens")
local treesitter = require("vulkanite.groups.treesitter")

local integration_keys = require("vulkanite.config").integration_keys

local integrations = {}
for _, key in ipairs(integration_keys) do
  local adapter = require("vulkanite.groups.integrations." .. key)
  local repo = adapter.url:match("github%.com/([^#?]+)"):gsub("%.git$", "")
  integrations[#integrations + 1] = {
    key = key,
    adapter = adapter,
    repos = { repo, repo:match("([^/]+)$") },
  }
end

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
        if
          matches_repo(plugin.name, integration.repos)
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
        if
          matches_repo(spec.name, integration.repos) or matches_repo(spec.src, integration.repos)
        then
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

function M.setup(roles, opts)
  local ret = {}

  merge(ret, base.setup(roles, opts))
  merge(ret, treesitter.setup(roles, opts))
  merge(ret, semantic_tokens.setup(roles, opts))
  kinds.kinds(ret, "LspKind%s", roles)

  local plugins = opts.plugins or {}
  local detected = detect_plugins(opts)
  for _, integration in ipairs(integrations) do
    if plugin_enabled(plugins, detected, integration.key) then
      merge(ret, integration.adapter.get(roles.integration, opts))
    end
  end

  return ret
end

return M
