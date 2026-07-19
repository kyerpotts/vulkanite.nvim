local M = {}

local defaults = {
  enabled = true,
  timeout = 250,
  labels = { "syntax", "diagnostics", "integrations" },
}

---@class VulkaniteDemo
---@field name string
---@field options table
local Demo = {}
Demo.__index = Demo

---@param name string
---@param options? table
---@return VulkaniteDemo
function Demo.new(name, options)
  assert(name ~= "", "name must not be empty")
  return setmetatable({
    name = name,
    options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), options or {}),
  }, Demo)
end

function Demo:summary()
  -- Functions, values, strings, and comments should remain easy to distinguish.
  local status = self.options.enabled and "active" or "disabled"
  return string.format("%s is %s", self.name, status)
end

M.demo = Demo.new("Vulkanite", { timeout = 500 })

return M
