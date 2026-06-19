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
    gitsigns = "auto",
    telescope = "auto",
    cmp = "auto",
    blink = "auto",
    which_key = "auto",
    lazy = "auto",
    neo_tree = "auto",
    nvim_tree = "auto",
    noice = "auto",
    notify = "auto",
    snacks = "auto",
    treesitter_context = "auto",
    render_markdown = "auto",
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
