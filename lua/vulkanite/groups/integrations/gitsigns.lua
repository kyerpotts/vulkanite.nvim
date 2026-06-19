local M = {}

M.url = "https://github.com/lewis6991/gitsigns.nvim"

function M.get(colors, opts)
  return {
    GitSignsAdd = { link = "Added" },
    GitSignsChange = { link = "Changed" },
    GitSignsDelete = { link = "Removed" },
    GitSignsTopdelete = { link = "GitSignsDelete" },
    GitSignsChangedelete = { fg = colors.yellow },
    GitSignsUntracked = { fg = colors.teal },
    GitSignsStagedAdd = { link = "GitSignsAdd" },
    GitSignsStagedChange = { link = "GitSignsChange" },
    GitSignsStagedDelete = { link = "GitSignsDelete" },
  }
end

return M
