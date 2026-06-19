local M = {}

M.url = "https://github.com/folke/snacks.nvim"

local function add_indent_groups(groups, colors)
  local rainbow = colors.rainbow
    or {
      colors.error,
      colors.warn,
      colors.yellow,
      colors.ok,
      colors.teal,
      colors.accent,
      colors.purple,
    }

  for index = 1, 7 do
    groups["SnacksIndent" .. index] = { fg = rainbow[index] or colors.gutter }
  end
end

function M.get(colors, opts)
  local groups = {
    SnacksNormal = { link = "Normal" },
    SnacksNormalNC = { link = "NormalNC" },
    SnacksNotifierBorderInfo = { fg = colors.info },
    SnacksNotifierBorderWarn = { fg = colors.warn },
    SnacksNotifierBorderError = { fg = colors.error },
    SnacksNotifierFooterInfo = { fg = colors.info },
    SnacksNotifierFooterWarn = { fg = colors.warn },
    SnacksNotifierFooterError = { fg = colors.error },
    SnacksNotifierIconInfo = { fg = colors.info },
    SnacksNotifierIconWarn = { fg = colors.warn },
    SnacksNotifierIconError = { fg = colors.error },
    SnacksNotifierTitleInfo = { fg = colors.info, bold = true },
    SnacksNotifierTitleWarn = { fg = colors.warn, bold = true },
    SnacksNotifierTitleError = { fg = colors.error, bold = true },

    SnacksDashboardDesc = { fg = colors.fg },
    SnacksDashboardFooter = { fg = colors.comment },
    SnacksDashboardHeader = { fg = colors.accent },
    SnacksDashboardIcon = { fg = colors.purple },
    SnacksDashboardKey = { fg = colors.warn },
    SnacksDashboardSpecial = { fg = colors.teal },
    SnacksDashboardTitle = { fg = colors.yellow, bold = true },

    SnacksIndent = { fg = colors.gutter },
    SnacksIndentScope = { fg = colors.accent },
    SnacksPicker = { link = "NormalFloat" },
    SnacksPickerBorder = { link = "FloatBorder" },
    SnacksPickerBoxBorder = { link = "FloatBorder" },
    SnacksPickerDir = { fg = colors.comment },
    SnacksPickerFile = { fg = colors.fg },
    SnacksPickerGitStatus = { fg = colors.comment },
    SnacksPickerGitStatusAdded = { fg = colors.ok },
    SnacksPickerGitStatusDeleted = { fg = colors.error },
    SnacksPickerGitStatusIgnored = { fg = colors.gutter },
    SnacksPickerGitStatusModified = { fg = colors.warn },
    SnacksPickerGitStatusRenamed = { fg = colors.teal },
    SnacksPickerGitStatusUntracked = { fg = colors.purple },
    SnacksPickerGitHubIssue = { fg = colors.info },
    SnacksPickerGitHubLabel = { fg = colors.purple },
    SnacksPickerGitHubPullRequest = { fg = colors.ok },
    SnacksPickerIcon = { fg = colors.teal },
    SnacksPickerInput = { link = "NormalFloat" },
    SnacksPickerInputBorder = { link = "FloatBorder" },
    SnacksPickerInputCursorLine = { link = "CursorLine" },
    SnacksPickerMatch = { fg = colors.yellow, bold = true },
    SnacksPickerPreviewCursorLine = { link = "CursorLine" },
    SnacksPickerSelected = { fg = colors.accent },
    SnacksPickerTitle = { link = "FloatTitle" },

    SnacksInput = { link = "NormalFloat" },
    SnacksInputBorder = { link = "FloatBorder" },
    SnacksInputIcon = { fg = colors.accent },
    SnacksInputTitle = { link = "FloatTitle" },

    SnacksProfilerBadge = { fg = colors.bg, bg = colors.accent, bold = true },
    SnacksProfilerIconInfo = { fg = colors.info },
    SnacksProfilerIconTrace = { fg = colors.purple },
    SnacksProfilerTitle = { fg = colors.accent, bold = true },
  }

  add_indent_groups(groups, colors)
  return groups
end

return M
