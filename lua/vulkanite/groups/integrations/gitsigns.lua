local M = {}

M.url = "https://github.com/lewis6991/gitsigns.nvim"

function M.get(colors, opts)
  return {
    -- Gitsigns sign-column marker for added lines.
    GitSignsAdd = { link = "Added" },
    -- Gitsigns sign-column marker for changed lines.
    GitSignsChange = { link = "Changed" },
    -- Gitsigns sign-column marker for deleted lines.
    GitSignsDelete = { link = "Removed" },
    -- Gitsigns sign-column marker for top-deleted lines.
    GitSignsTopdelete = { link = "GitSignsDelete" },
    -- Gitsigns sign-column marker for changed lines with deleted content.
    GitSignsChangedelete = { fg = colors.match },
    -- Gitsigns sign-column marker for untracked lines.
    GitSignsUntracked = { fg = colors.accent_secondary },
    -- Gitsigns staged sign-column marker for added lines.
    GitSignsStagedAdd = { link = "GitSignsAdd" },
    -- Gitsigns staged sign-column marker for changed lines.
    GitSignsStagedChange = { link = "GitSignsChange" },
    -- Gitsigns staged sign-column marker for deleted lines.
    GitSignsStagedDelete = { link = "GitSignsDelete" },
  }
end

return M
