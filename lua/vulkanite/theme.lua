local colors_mod = require("vulkanite.colors")
local groups_mod = require("vulkanite.groups")

local M = {}

local function apply_highlights(groups)
  for group, highlight in pairs(groups) do
    vim.api.nvim_set_hl(0, group, highlight)
  end
end

local function apply_terminal_colors(colors)
  for index = 0, 15 do
    vim.g["terminal_color_" .. index] = colors and colors.terminal[index + 1] or nil
  end
end

function M.setup(opts)
  local colors = colors_mod.setup(opts)
  local groups = groups_mod.setup(colors.roles, opts)

  vim.cmd("highlight clear")

  vim.o.termguicolors = true
  vim.g.colors_name = "vulkanite"

  opts.on_highlights(groups, colors)
  apply_highlights(groups)

  apply_terminal_colors(opts.terminal_colors and colors or nil)
end

return M
