local M = {}

M.url = "https://github.com/folke/snacks.nvim"

local function add_indent_groups(groups, colors)
  local rainbow = colors.rainbow
    or {
      colors.value,
      colors.warn,
      colors.match,
      colors.ok,
      colors.accent_secondary,
      colors.accent,
      colors.icon,
    }

  for index = 1, 7 do
    -- Snacks indent guide color for nesting level index.
    groups["SnacksIndent" .. index] = { fg = rainbow[index] or colors.gutter }
  end
end

function M.get(colors, opts)
  local groups = {
    -- Snacks default normal window text.
    SnacksNormal = { link = "Normal" },
    -- Snacks non-current normal window text.
    SnacksNormalNC = { link = "NormalNC" },
    -- Snacks notifier border for informational notifications.
    SnacksNotifierBorderInfo = { fg = colors.info },
    -- Snacks notifier border for warning notifications.
    SnacksNotifierBorderWarn = { fg = colors.warn },
    -- Snacks notifier border for error notifications.
    SnacksNotifierBorderError = { fg = colors.error },
    -- Snacks notifier footer for informational notifications.
    SnacksNotifierFooterInfo = { fg = colors.info },
    -- Snacks notifier footer for warning notifications.
    SnacksNotifierFooterWarn = { fg = colors.warn },
    -- Snacks notifier footer for error notifications.
    SnacksNotifierFooterError = { fg = colors.error },
    -- Snacks notifier icon for informational notifications.
    SnacksNotifierIconInfo = { fg = colors.info },
    -- Snacks notifier icon for warning notifications.
    SnacksNotifierIconWarn = { fg = colors.warn },
    -- Snacks notifier icon for error notifications.
    SnacksNotifierIconError = { fg = colors.error },
    -- Snacks notifier title for informational notifications.
    SnacksNotifierTitleInfo = { fg = colors.info, bold = true },
    -- Snacks notifier title for warning notifications.
    SnacksNotifierTitleWarn = { fg = colors.warn, bold = true },
    -- Snacks notifier title for error notifications.
    SnacksNotifierTitleError = { fg = colors.error, bold = true },

    -- Snacks dashboard item descriptions.
    SnacksDashboardDesc = { fg = colors.fg },
    -- Snacks dashboard footer text.
    SnacksDashboardFooter = { fg = colors.comment },
    -- Snacks dashboard header art or title block.
    SnacksDashboardHeader = { fg = colors.accent },
    -- Snacks dashboard item icons.
    SnacksDashboardIcon = { fg = colors.icon },
    -- Snacks dashboard shortcut keys.
    SnacksDashboardKey = { fg = colors.value },
    -- Snacks dashboard special symbols.
    SnacksDashboardSpecial = { fg = colors.accent_secondary },
    -- Snacks dashboard section titles.
    SnacksDashboardTitle = { fg = colors.match, bold = true },

    -- Snacks indent guide default color.
    SnacksIndent = { fg = colors.gutter },
    -- Snacks active indent scope guide.
    SnacksIndentScope = { fg = colors.accent },
    -- Snacks picker window body.
    SnacksPicker = { link = "NormalFloat" },
    -- Snacks picker outer border.
    SnacksPickerBorder = { link = "FloatBorder" },
    -- Snacks picker boxed layout border.
    SnacksPickerBoxBorder = { link = "FloatBorder" },
    -- Snacks picker directory portion of paths.
    SnacksPickerDir = { fg = colors.comment },
    -- Snacks picker file names.
    SnacksPickerFile = { fg = colors.fg },
    -- Snacks picker generic git-status text.
    SnacksPickerGitStatus = { fg = colors.comment },
    -- Snacks picker added git-status entries.
    SnacksPickerGitStatusAdded = { fg = colors.ok },
    -- Snacks picker deleted git-status entries.
    SnacksPickerGitStatusDeleted = { fg = colors.value },
    -- Snacks picker ignored git-status entries.
    SnacksPickerGitStatusIgnored = { fg = colors.gutter },
    -- Snacks picker modified git-status entries.
    SnacksPickerGitStatusModified = { fg = colors.match },
    -- Snacks picker renamed git-status entries.
    SnacksPickerGitStatusRenamed = { fg = colors.accent_secondary },
    -- Snacks picker untracked git-status entries.
    SnacksPickerGitStatusUntracked = { fg = colors.accent_secondary },
    -- Snacks picker Git issue references.
    SnacksPickerGitIssue = { fg = colors.info },
    -- Snacks picker source or file icons.
    SnacksPickerIcon = { fg = colors.icon },
    -- Snacks picker input window body.
    SnacksPickerInput = { link = "NormalFloat" },
    -- Snacks picker input window border.
    SnacksPickerInputBorder = { link = "FloatBorder" },
    -- Snacks picker cursor line in the input list.
    SnacksPickerInputCursorLine = { link = "CursorLine" },
    -- Snacks picker matched query text.
    SnacksPickerMatch = { fg = colors.match, bold = true },
    -- Snacks picker preview cursor line.
    SnacksPickerPreviewCursorLine = { link = "CursorLine" },
    -- Snacks picker selected item marker.
    SnacksPickerSelected = { fg = colors.accent },
    -- Snacks picker title text.
    SnacksPickerTitle = { link = "FloatTitle" },

    -- Snacks input prompt body.
    SnacksInput = { link = "NormalFloat" },
    -- Snacks input prompt border.
    SnacksInputBorder = { link = "FloatBorder" },
    -- Snacks input prompt icon.
    SnacksInputIcon = { fg = colors.icon },
    -- Snacks input prompt title.
    SnacksInputTitle = { link = "FloatTitle" },

    -- Snacks profiler badge text.
    SnacksProfilerBadge = { fg = colors.bg, bg = colors.accent, bold = true },
    -- Snacks profiler informational icon.
    SnacksProfilerIconInfo = { fg = colors.info },
    -- Snacks profiler trace icon.
    SnacksProfilerIconTrace = { fg = colors.icon },
  }

  add_indent_groups(groups, colors)
  return groups
end

return M
