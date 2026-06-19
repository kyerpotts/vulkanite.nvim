local colors_mod = require("vulkanite.colors")
local groups_mod = require("vulkanite.groups")

local M = {}

local function apply_highlights(groups)
  for group, highlight in pairs(groups) do
    vim.api.nvim_set_hl(0, group, highlight)
  end
end

local function apply_terminal_colors(colors)
  for index, color in ipairs(colors.terminal) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

function M.setup(opts)
  local colors = colors_mod.setup(opts)
  local groups = groups_mod.setup(colors, opts)

  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "vulkanite"

  opts.on_highlights(groups, colors)
  apply_highlights(groups)

  if opts.terminal_colors then
    apply_terminal_colors(colors)
  end
end

return M
