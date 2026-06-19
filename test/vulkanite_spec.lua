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

  vulkanite.setup({})
  package.loaded["vulkan-colors"] = nil
  vim.cmd.colorscheme("vulkanite")
  assert_eq(vim.g.colors_name, "vulkanite", "colorscheme name")
  assert_eq(
    package.loaded["vulkan-colors"],
    nil,
    "vulkan-colors module stays unloaded after colorscheme vulkanite"
  )
  assert_truthy(vim.api.nvim_get_hl(0, { name = "Normal" }).fg, "Normal fg set")
  assert_truthy(vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg, "DiagnosticError fg set")
  assert_link_or_fg("@function", "Function", "@function")
  assert_link_or_fg("@lsp.type.function", "Function", "@lsp.type.function")
  assert_truthy(vim.api.nvim_get_hl(0, { name = "LspKindFunction" }).fg, "LspKindFunction fg set")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, 0x0f1416, "Normal uses original base00")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg,
    0x0f1416,
    "NormalFloat uses original base01"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Statement" }).fg,
    0x37868b,
    "Statement uses original base0E"
  )
  local palette = require("vulkanite.palette").get()
  assert_eq(palette.base0E, "#37868b", "base0E stays original teal")
  assert_eq(palette.orange, "#e08a64", "extended orange accent exists")
  assert_eq(palette.purple, "#7b78aa", "extended purple accent exists")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg,
    0xe08a64,
    "WarningMsg uses extended orange"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg,
    0xe08a64,
    "DiagnosticWarn uses extended orange"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "Constant" }).fg,
    0xe05f64,
    "Constant stays original red"
  )
  assert_eq(vim.api.nvim_get_hl(0, { name = "Number" }).fg, 0xe05f64, "Number stays original red")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Boolean" }).fg, 0xe05f64, "Boolean stays original red")
  assert_eq(vim.api.nvim_get_hl(0, { name = "Float" }).fg, 0xe05f64, "Float stays original red")
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindConstant" }).fg,
    0xe05f64,
    "constant kind stays red"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "@lsp.type.decorator" }).fg,
    0x7b78aa,
    "decorators use extended purple"
  )
  assert_eq(
    vim.api.nvim_get_hl(0, { name = "LspKindSnippet" }).fg,
    0x7b78aa,
    "snippets use extended purple"
  )
  assert_eq(vim.g.terminal_color_5, "#7b78aa", "terminal magenta uses extended purple")

  reset_vulkanite()
  require("vulkanite").load({ terminal_colors = false })
  assert_eq(vim.g.terminal_color_0, nil, "terminal colors stay unset when disabled")

  reset_vulkanite()
  require("vulkanite").load({ transparent = true })
  assert_eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, nil, "transparent Normal background")

  local opts = require("vulkanite.config").extend({ transparent = true })
  local colors = require("vulkanite.colors").setup(opts)
  local groups = require("vulkanite.groups").setup(colors, opts)
  local raw_normal = groups.Normal
  assert_eq(raw_normal.bg, nil, "raw transparent Normal background is omitted before apply")
  assert_eq(groups.Normal.bg, nil, "transparent Normal background is omitted before apply")

  local colors_without_callbacks = require("vulkanite.colors").setup({})
  assert_eq(colors_without_callbacks.error, "#e05f64", "colors.setup defaults missing callbacks")

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

  reset_vulkanite()
  require("vulkanite").load({
    plugins = { auto = false, all = false, snacks = true, telescope = false },
  })
  assert_truthy(
    vim.api.nvim_get_hl(0, { name = "SnacksPickerMatch" }).fg,
    "manual snacks toggle sets picker match"
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

  reset_vulkanite()
  package.loaded["vulkan-colors"] = nil
  local lualine_theme = require("lualine.themes.vulkanite")
  assert_eq(type(lualine_theme), "table", "lualine theme is a table")
  for _, mode in ipairs({ "normal", "insert", "command", "visual", "replace", "terminal" }) do
    assert_truthy(lualine_theme[mode].a.bg, "lualine " .. mode .. ".a.bg set")
  end
  assert_truthy(lualine_theme.inactive.a.fg, "lualine inactive.a.fg set")

  reset_vulkanite()
  package.loaded["vulkan-colors"] = nil
  require("vulkanite").load()
  assert_eq(
    package.loaded["vulkan-colors"],
    nil,
    "vulkan-colors module stays unloaded after loading vulkanite"
  )

  reset_vulkanite()
  package.loaded["vulkan-colors"] = nil
  vim.cmd.colorscheme("vulkan-colors")
  assert_eq(vim.g.colors_name, "vulkanite", "compat colorscheme reports vulkanite")
  assert_eq(
    package.loaded["vulkan-colors"],
    nil,
    "compat colorscheme does not load vulkan-colors module"
  )
end

local ok, err = xpcall(run, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd.cquit(1)
end
