local M = {}

local defaults = {
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    strings = { italic = true },
    variables = {},
  },
  plugins = {
    auto = true,
    all = false,
    gitsigns = true,
    telescope = true,
    cmp = true,
    blink = true,
    which_key = true,
    lazy = true,
    neo_tree = true,
    nvim_tree = true,
    noice = true,
    notify = true,
    snacks = true,
    treesitter_context = true,
    render_markdown = true,
  },
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
