local function assert_eq(actual, expected, message)
  if actual ~= expected then
    error(
      (message or "assertion failed")
        .. ": expected "
        .. vim.inspect(expected)
        .. ", got "
        .. vim.inspect(actual),
      2
    )
  end
end

local function assert_truthy(value, message)
  if not value then
    error(message or "expected truthy value", 2)
  end
end

local function luminance(hex)
  local channels = {}
  for index = 2, 6, 2 do
    local value = tonumber(hex:sub(index, index + 1), 16) / 255
    channels[#channels + 1] = value <= 0.04045 and value / 12.92 or ((value + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * channels[1] + 0.7152 * channels[2] + 0.0722 * channels[3]
end

local function contrast(foreground, background)
  local lighter = math.max(luminance(foreground), luminance(background))
  local darker = math.min(luminance(foreground), luminance(background))
  return (lighter + 0.05) / (darker + 0.05)
end

local function assert_contrast(foreground, background, minimum, message)
  local actual = contrast(foreground, background)
  if actual < minimum then
    error(
      (message or "insufficient contrast")
        .. ": expected at least "
        .. minimum
        .. ", got "
        .. actual,
      2
    )
  end
end

local function assert_link_or_fg(group, link, message)
  local highlight = vim.api.nvim_get_hl(0, { name = group, link = true })
  if highlight.link ~= link and highlight.fg == nil then
    error(
      (message or group .. " should link to " .. link .. " or set fg")
        .. ": got "
        .. vim.inspect(highlight),
      2
    )
  end
end

local function assert_unset(group, message)
  local highlight = vim.api.nvim_get_hl(0, { name = group, link = true })
  if next(highlight) ~= nil then
    error((message or group .. " should be unset") .. ": got " .. vim.inspect(highlight), 2)
  end
end

local function assert_set(group, message)
  local highlight = vim.api.nvim_get_hl(0, { name = group, link = true })
  if next(highlight) == nil then
    error(message or group .. " should be set", 2)
  end
end

local integration_probe_groups = {
  "GitSignsAdd",
  "TelescopeMatching",
  "CmpItemAbbrMatch",
  "BlinkCmpLabelMatch",
  "WhichKey",
  "LazyH1",
  "NeoTreeDirectoryName",
  "NvimTreeFolderName",
  "NoiceCmdlinePopup",
  "NotifyINFOIcon",
  "SnacksPickerMatch",
  "TreesitterContext",
  "RenderMarkdownH1",
}

local function clear_integration_probe_groups()
  for _, group in ipairs(integration_probe_groups) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

local function reset_vulkanite()
  for name in pairs(package.loaded) do
    if name == "vulkanite" or name:match("^vulkanite%.") then
      package.loaded[name] = nil
    end
  end
  vim.g.colors_name = nil
  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = nil
  end
  clear_integration_probe_groups()
end

local function run()
  reset_vulkanite()
  local vulkanite = require("vulkanite")
  assert_truthy(vulkanite, "vulkanite module should load")
  assert_eq(type(vulkanite.setup), "function", "setup exists")
  assert_eq(type(vulkanite.load), "function", "load exists")
  assert_eq(type(require("vulkanite.palette").get), "function", "palette get exists")
  for key in pairs(require("vulkanite.config").extend().plugins) do
    if key ~= "auto" and key ~= "all" then
      local adapter = require("vulkanite.groups.integrations." .. key)
      assert_eq(type(adapter.get), "function", key .. " integration exports get")
      assert_truthy(
        adapter.url:match("^https://github%.com/"),
        key .. " integration owns repository metadata"
      )
    end
  end

  vulkanite.setup({})
  vim.cmd.colorscheme("vulkanite")
  assert_eq(vim.g.colors_name, "vulkanite", "colorscheme name")
  assert_truthy(vim.api.nvim_get_hl(0, { name = "Normal" }).fg, "Normal fg set")
  assert_truthy(vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg, "DiagnosticError fg set")
  assert_link_or_fg("@function", "Function", "@function")
  assert_link_or_fg("@lsp.type.function", "Function", "@lsp.type.function")
  assert_truthy(vim.api.nvim_get_hl(0, { name = "LspKindFunction" }).fg, "LspKindFunction fg set")
  local function_highlight = vim.api.nvim_get_hl(0, { name = "Function" })
  assert_eq(function_highlight.italic, true, "function names are italic")
  assert_eq(function_highlight.bold, nil, "function names are not bold")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@function.builtin", link = true }).link,
    "Function",
    "built-in functions share the function style"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "String" }).italic, nil, "strings are upright")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Comment" }).italic, true, "comments are italic")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspInlayHint" }).italic,
    true,
    "inlay hints are italic"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@text.emphasis" }).italic,
    true,
    "markup emphasis is italic"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "Type" }).italic, nil, "type names are upright")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Type" }).bold, true, "type names are bold")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Structure", link = true }).link,
    "Type",
    "structures share the type style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@type.builtin", link = true }).link,
    "Type",
    "built-in types share the type style"
  )
  local constructor_highlight = vim.api.nvim_get_hl(0, { name = "@constructor", link = false })
  assert_eq(constructor_highlight.bold, true, "constructors use the bold type style")
  assert_eq(constructor_highlight.italic, true, "constructors are italic")
  assert_eq(
    constructor_highlight.nocombine,
    true,
    "constructors do not inherit overlapping function-call styles"
  )
  assert_unset("@lsp.mod.definition", "LSP definitions do not add generic bold styling")
  assert_unset("@lsp.mod.declaration", "LSP declarations do not add generic bold styling")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, 0x0f1416, "Normal uses dark black")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg,
    0x151b1e,
    "NormalFloat uses soft black"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg,
    0x151b1e,
    "CursorLine uses the distinct alternate background"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "CursorLineNr" }).fg,
    0x8fe0fa,
    "CursorLineNr marks the cursor line with the accent"
  )
  local search_highlight = vim.api.nvim_get_hl(0, { name = "Search", link = false })
  assert_eq(search_highlight.fg, 0x151b1e, "Search uses dark text")
  assert_eq(search_highlight.bg, 0x76c7e3, "Search uses one blue background")
  assert_eq(search_highlight.nocombine, true, "Search does not combine with syntax highlights")
  local current_search = vim.api.nvim_get_hl(0, { name = "CurSearch", link = false })
  assert_eq(current_search.fg, search_highlight.fg, "CurSearch keeps the search foreground")
  assert_eq(current_search.bg, 0xe0af68, "CurSearch uses the yellow current-match background")
  assert_eq(current_search.nocombine, true, "CurSearch does not combine with syntax highlights")
  assert_eq(current_search.underline, nil, "CurSearch does not underline the current match")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "IncSearch", link = true }).link,
    "CurSearch",
    "IncSearch follows the current-match style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Substitute", link = true }).link,
    "Search",
    "Substitute follows the ordinary-match style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "QuickFixLine" }).bg,
    0x5c6370,
    "QuickFixLine uses slate-grey selection"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Visual" }).bg,
    0x5c6370,
    "Visual uses slate-grey selection"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Visual" }).fg,
    0xdce5e9,
    "Visual uses pale selected text"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "PmenuSel" }).bg,
    0x5c6370,
    "PmenuSel uses slate-grey selection"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "PmenuSel" }).fg,
    0xdce5e9,
    "PmenuSel uses pale selected text"
  )
  for _, group in ipairs({ "Visual", "VisualNOS", "PmenuSel", "QuickFixLine", "WildMenu" }) do
    local highlight = vim.api.nvim_get_hl(0, { name = group })
    assert_eq(highlight.bg, 0x5c6370, group .. " uses the shared slate-grey selection background")
    assert_eq(highlight.fg, 0xdce5e9, group .. " uses the shared pale selection foreground")
    assert_eq(highlight.bold, nil, group .. " does not force selected text bold")
  end
  assert_eq(vim.api.nvim_get_hl(0, { name = "Statement" }).fg, 0x37868b, "Statement uses dark teal")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Statement" }).bold, nil, "statements are not bold")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Keyword", link = true }).link,
    "Statement",
    "keywords share statement style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Conditional", link = true }).link,
    "Statement",
    "conditionals share statement style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Repeat", link = true }).link,
    "Statement",
    "loops share statement style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Operator" }).fg,
    0xdce5e9,
    "Operator uses the bright foreground"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindOperator" }).fg,
    0xdce5e9,
    "operator completion kinds use the bright foreground"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "Type" }).fg, 0x76c7e3, "Type uses sky blue")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindClass" }).fg,
    0x76c7e3,
    "class kinds use sky blue"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "Label" }).fg, 0x76c7e3, "Label uses sky blue")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Exception", link = true }).link,
    "Statement",
    "exception syntax uses the keyword role"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Special" }).fg,
    0x567e96,
    "special syntax uses muted blue"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@string.documentation" }).fg,
    0xe0af68,
    "documentation strings use exact yellow"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@variable" }).fg,
    0xe05f64,
    "variables retain coral red"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "FloatBorder" }).fg,
    0x567e96,
    "float borders are subdued"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "TooLong" }).fg, 0xe0af68, "TooLong uses warning")
  assert_eq(vim.api.nvim_get_hl(0, { name = "WildMenu" }).fg, 0xdce5e9, "WildMenu is readable")
  assert_eq(vim.api.nvim_get_hl(0, { name = "DiffText" }).fg, 0xdce5e9, "DiffText is readable")
  local palette = require("vulkanite.palette").get()
  assert_eq(palette.dark_black, "#0f1416", "named palette exposes dark black")
  assert_eq(palette.soft_black, "#151b1e", "named palette exposes soft black")
  assert_eq(palette.sky_blue, "#76c7e3", "named palette exposes sky blue")
  assert_eq(palette.bright_blue, "#8fe0fa", "named palette exposes bright blue")
  assert_eq(palette.base16.base0E, palette.dark_teal, "Base16 roles map to named colors")
  assert_eq(palette.base09, nil, "Base16 roles are not top-level palette colors")
  local authored_colors = {}
  for name, color in pairs(palette) do
    if type(color) == "string" then
      assert_eq(authored_colors[color], nil, name .. " must be a unique authored color")
      authored_colors[color] = name
    end
  end
  assert_eq(vim.tbl_count(authored_colors), 16, "palette has exactly 16 authored colors")
  assert_eq(vim.tbl_count(palette.base16), 16, "Base16 mapping has all 16 roles")
  for name, color in pairs(palette.base16) do
    assert_truthy(authored_colors[color], name .. " maps to an authored color")
  end
  assert_eq(palette.yellow, "#e0af68", "yellow is part of the palette identity")
  assert_eq(palette.bright_teal, "#4fa3a6", "bright teal is part of the palette identity")
  assert_eq(palette.purple, "#9083B9", "purple is part of the palette identity")
  assert_contrast(palette.pale_grey, palette.dark_black, 7, "normal text contrast")
  assert_contrast(palette.comment_grey, palette.dark_black, 4.5, "comment contrast")
  assert_contrast(palette.pale_grey, palette.slate_grey, 4.5, "selection contrast")
  assert_contrast(palette.dark_teal, palette.dark_black, 4, "keyword contrast")
  assert_contrast(palette.vivid_red, palette.dark_black, 4, "diagnostic contrast")
  assert_contrast(palette.purple, palette.dark_black, 4.5, "constant contrast")
  assert_contrast(palette.yellow, palette.dark_black, 9, "documentation string contrast")
  local semantic_colors = require("vulkanite.colors").setup({})
  assert_eq(semantic_colors.syntax, nil, "public overrides stay separate from internal roles")
  assert_eq(
    semantic_colors.roles.syntax.keyword,
    "#37868b",
    "syntax keyword role is derived centrally"
  )
  assert_eq(
    semantic_colors.roles.diagnostic.error,
    "#e03f32",
    "diagnostic role is derived centrally"
  )
  assert_eq(semantic_colors.roles.accent.icon, "#9083B9", "icon role is derived centrally")
  assert_eq(vim.api.nvim_get_hl(0, { name = "ErrorMsg" }).fg, 0xe03f32, "ErrorMsg uses vivid red")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
    0xe03f32,
    "DiagnosticError uses vivid red"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg, 0xe0af68, "WarningMsg uses yellow")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg,
    0xe0af68,
    "DiagnosticWarn uses yellow"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@variable.parameter" }).fg,
    0xe05f64,
    "parameters use coral red"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@property" }).fg,
    0xdce5e9,
    "properties use the bright foreground"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@variable.member" }).fg,
    0xdce5e9,
    "members use the bright foreground"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindField" }).fg,
    0xdce5e9,
    "field completion kinds use the bright foreground"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindProperty" }).fg,
    0xdce5e9,
    "property completion kinds use the bright foreground"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "Constant" }).fg, 0x9083b9, "constants use purple")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Constant" }).bold, true, "constants are bold")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Constant" }).italic, nil, "constants are not italic")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Number" }).fg, 0xe05f64, "Number uses coral red")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Boolean" }).fg, 0xe05f64, "Boolean uses coral red")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Float" }).fg, 0xe05f64, "Float uses coral red")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindConstant" }).fg,
    0x9083b9,
    "constant kinds use purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindEnumMember" }).fg,
    0x9083b9,
    "enum-member kinds use purple"
  )
  assert_link_or_fg("@lsp.type.variable", "@variable", "semantic variables follow Tree-sitter")
  assert_link_or_fg("@lsp.type.namespace", "@module", "semantic namespaces follow Tree-sitter")
  assert_unset("@lsp.mod.readonly", "readonly modifier preserves the underlying style")
  assert_unset("@lsp.mod.defaultLibrary", "default-library modifier preserves the underlying style")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@variable.builtin", link = true }).link,
    "@variable",
    "built-in variables preserve the variable style"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@lsp.typemod.variable.readonly", link = true }).link,
    "@variable",
    "readonly variables preserve the variable style"
  )
  assert_link_or_fg("@lsp.type.decorator", "Special", "decorators use the special syntax role")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindSnippet" }).fg,
    0x9083b9,
    "kind icons use purple"
  )
  assert_eq(vim.g.terminal_color_3, "#e0af68", "terminal yellow uses authored yellow")
  assert_eq(vim.g.terminal_color_5, "#9083B9", "terminal magenta uses authored purple")
  assert_eq(vim.g.terminal_color_11, "#e0af68", "terminal bright yellow uses authored yellow")

  require("vulkanite").load({ terminal_colors = false })
  for index = 0, 15 do
    assert_eq(
      vim.g["terminal_color_" .. index],
      nil,
      "disabled terminal colors clear index " .. index
    )
  end
  require("vulkanite").load({ terminal_colors = true })
  assert_eq(vim.g.terminal_color_0, "#0f1416", "terminal colors can be enabled again")

  reset_vulkanite()
  require("vulkanite").load({ transparent = true })
  assert_eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, nil, "transparent Normal background")
  require("vulkanite").load({ transparent = false })
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
    0x0f1416,
    "opaque reload restores background"
  )

  local opts = require("vulkanite.config").extend({ transparent = true })
  local colors = require("vulkanite.colors").setup(opts)
  local groups = require("vulkanite.groups").setup(colors.roles, opts)
  local raw_normal = groups.Normal
  assert_eq(raw_normal.bg, nil, "raw transparent Normal background is omitted before apply")
  assert_eq(groups.Normal.bg, nil, "transparent Normal background is omitted before apply")

  local colors_without_callbacks = require("vulkanite.colors").setup({})
  assert_eq(colors_without_callbacks.error, "#e03f32", "colors.setup defaults missing callbacks")

  reset_vulkanite()
  require("vulkanite").load({
    styles = {
      comments = { italic = false },
      functions = { italic = false },
      types = { bold = false },
      constants = { bold = false },
    },
  })
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Comment" }).italic,
    nil,
    "comment italics can be disabled"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Function" }).italic,
    nil,
    "function italics can be disabled"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "Type" }).bold, nil, "type bold can be disabled")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Constant" }).bold,
    nil,
    "constant bold can be disabled"
  )
  require("vulkanite").load({})
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Comment" }).italic,
    true,
    "style reload restores defaults"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Function" }).italic,
    true,
    "function style reload restores italic default"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Type" }).bold,
    true,
    "type style reload restores bold default"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Type" }).italic,
    nil,
    "type style reload restores upright default"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Constant" }).bold,
    true,
    "constant style reload restores defaults"
  )

  reset_vulkanite()
  require("vulkanite").load({
    on_colors = function(colors)
      colors.error = "#ff0000"
    end,
    on_highlights = function(groups, colors)
      groups.VulkaniteOverrideProbe = { fg = colors.error }
    end,
  })
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
    0xff0000,
    "on_colors mutates error"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "VulkaniteOverrideProbe" }).fg,
    0xff0000,
    "on_highlights sees colors"
  )
  require("vulkanite").load({})
  assert_unset("VulkaniteOverrideProbe", "reload clears callback-defined highlights")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
    0xe03f32,
    "reload restores default semantic colors"
  )

  reset_vulkanite()
  require("vulkanite").load({
    plugins = { auto = false, all = false, snacks = true, telescope = false },
  })
  assert_truthy(
    vim.api.nvim_get_hl(0, { name = "SnacksPickerMatch" }).fg,
    "manual snacks toggle sets picker match"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "SnacksDashboardIcon" }).fg,
    0x9083b9,
    "Snacks icons stay purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "SnacksDashboardKey" }).fg,
    0xe05f64,
    "Snacks keys use red"
  )
  assert_unset("TelescopeMatching", "manual telescope false keeps telescope unset")

  reset_vulkanite()
  local old_lazy_config = package.loaded["lazy.core.config"]
  local old_lazy = package.loaded.lazy
  package.loaded["lazy.core.config"] = { plugins = { ["folke/snacks.nvim"] = {} } }
  package.loaded.lazy = {}
  require("vulkanite").load({ plugins = { auto = true, all = false, snacks = false } })
  package.loaded["lazy.core.config"] = old_lazy_config
  package.loaded.lazy = old_lazy
  assert_unset("SnacksPickerMatch", "manual snacks false beats lazy.nvim auto-detection")

  reset_vulkanite()
  require("vulkanite").load({ plugins = { auto = true, all = false } })
  assert_unset("SnacksPickerMatch", "auto mode leaves undetected snacks unset")

  reset_vulkanite()
  local old_pack = vim.pack
  vim.pack = {
    get = function()
      return {
        { spec = { name = "snacks.nvim", src = "https://github.com/folke/snacks.nvim" } },
      }
    end,
  }
  require("vulkanite").load({ plugins = { auto = true, all = false } })
  vim.pack = old_pack
  assert_truthy(
    vim.api.nvim_get_hl(0, { name = "SnacksPickerMatch" }).fg,
    "vim.pack auto-detects snacks.nvim"
  )

  reset_vulkanite()
  require("vulkanite").load({ plugins = { auto = false, all = true } })
  for _, group in ipairs(integration_probe_groups) do
    assert_set(group, group .. " exists with plugins.all")
  end
  assert_set("WhichKeyNormal", "current which-key normal group exists")
  assert_set("SnacksPickerGitIssue", "current Snacks Git issue group exists")
  assert_unset("WhichKeyFloat", "obsolete which-key group is not defined")
  assert_unset("SnacksPickerGitHubIssue", "obsolete Snacks GitHub issue group is not defined")
  assert_eq(vim.api.nvim_get_hl(0, { name = "LazyValue" }).fg, 0xe05f64, "LazyValue uses value red")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindUnit" }).fg,
    0xe05f64,
    "unit kind uses value red"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindColor" }).fg,
    0xe05f64,
    "color kind uses value red"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "SnacksDashboardIcon" }).fg,
    0x9083b9,
    "Snacks icon uses purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "NotifyTRACEIcon" }).fg,
    0x9083b9,
    "Notify trace icon uses purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "WhichKeyGroup" }).fg,
    0x8fe0fa,
    "WhichKeyGroup is not purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "RenderMarkdownH2" }).fg,
    0x8fe0fa,
    "Markdown heading is not purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "NeoTreeRootName" }).fg,
    0x8fe0fa,
    "Neo-tree root is not purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LazyReasonPlugin" }).fg,
    0x567e96,
    "Lazy reason is not purple"
  )
  require("vulkanite").load({ plugins = { auto = false, all = false } })
  for _, group in ipairs(integration_probe_groups) do
    assert_unset(group, group .. " is cleared when integrations are disabled on reload")
  end

  reset_vulkanite()
  package.loaded["lualine.themes.vulkanite"] = nil
  local on_colors_calls = 0
  require("vulkanite").setup({
    on_colors = function(colors)
      on_colors_calls = on_colors_calls + 1
      colors.accent = "#ff00ff"
    end,
  })
  require("lualine.themes.vulkanite")
  assert_eq(on_colors_calls, 0, "requiring the lualine theme does not run on_colors")
  vim.cmd.colorscheme("vulkanite")
  assert_eq(on_colors_calls, 1, "loading Vulkanite runs on_colors once")
  package.loaded["lualine.themes.vulkanite"] = nil
  local customized_lualine = require("lualine.themes.vulkanite")
  assert_eq(on_colors_calls, 1, "lualine reuses resolved colors without rerunning on_colors")
  assert_eq(customized_lualine.normal.a.bg, "#ff00ff", "lualine uses resolved color overrides")

  reset_vulkanite()
  package.loaded["lualine.themes.vulkanite"] = nil
  local lualine_theme = require("lualine.themes.vulkanite")
  assert_eq(type(lualine_theme), "table", "lualine theme is a table")
  for _, mode in ipairs({ "normal", "insert", "command", "visual", "replace", "terminal" }) do
    assert_truthy(lualine_theme[mode].a.bg, "lualine " .. mode .. ".a.bg set")
  end
  assert_eq(lualine_theme.visual.a.bg, "#9083B9", "visual mode uses purple")
  assert_eq(lualine_theme.terminal.a.bg, "#4fa3a6", "terminal mode uses bright teal")
  assert_eq(lualine_theme.inactive.a.fg, "#abb2bf", "inactive lualine uses dim foreground")
  assert_eq(lualine_theme.inactive.a.bg, "#151b1e", "inactive lualine uses soft black")
end

local ok, err = xpcall(run, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd.cquit(1)
end
