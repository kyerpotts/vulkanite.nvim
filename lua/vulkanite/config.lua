local M = {}

M.integration_keys = {
  "gitsigns",
  "telescope",
  "cmp",
  "blink",
  "which_key",
  "lazy",
  "neo_tree",
  "nvim_tree",
  "noice",
  "notify",
  "snacks",
  "treesitter_context",
  "render_markdown",
}

local plugin_defaults = {
  auto = true,
  all = false,
}
for _, key in ipairs(M.integration_keys) do
  plugin_defaults[key] = "auto"
end

local defaults = {
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = { italic = true },
    types = { bold = true },
    constants = { bold = true },
    strings = {},
    variables = {},
  },
  plugins = plugin_defaults,
  on_colors = function() end,
  on_highlights = function() end,
}

M.options = vim.deepcopy(defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
  return M.options
end

function M.extend(opts)
  return vim.tbl_deep_extend("force", vim.deepcopy(M.options), opts or {})
end

return M
