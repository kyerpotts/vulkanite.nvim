# Vulkanite MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the current `vulkan-colors.nvim` plugin into `vulkanite.nvim` with a modern setup API, modular highlight architecture, LazyVim/vim.pack-friendly docs, MVP integrations, and lualine support.

**Architecture:** Keep the runtime shape boring: a thin colorscheme entry calls `require("vulkanite").load()`, config/palette/colors modules compute state, `theme.lua` applies highlights, and `groups/` modules return highlight tables. Integrations are opt-in/auto-detected through one registry and one module contract.

**Tech Stack:** Lua, Neovim headless smoke tests, stylua.

---

## File structure

Create:

- `colors/vulkanite.lua`: new colorscheme entrypoint.
- `lua/vulkanite/init.lua`: public `setup`, `load`, `config`, `colors`, and `groups` API.
- `lua/vulkanite/config.lua`: defaults, deep-merge, plugin toggle resolution helpers.
- `lua/vulkanite/palette.lua`: raw Vulkanite palette and `get()` API.
- `lua/vulkanite/colors.lua`: semantic color expansion.
- `lua/vulkanite/theme.lua`: highlight application and terminal colors.
- `lua/vulkanite/groups/init.lua`: core group composition, integration registry, lazy.nvim/vim.pack detection.
- `lua/vulkanite/groups/base.lua`: editor UI, syntax, diagnostics, diff, LSP base groups.
- `lua/vulkanite/groups/treesitter.lua`: Tree-sitter captures.
- `lua/vulkanite/groups/semantic_tokens.lua`: LSP semantic token captures.
- `lua/vulkanite/groups/kinds.lua`: completion/LSP kind helper.
- `lua/vulkanite/groups/integrations/*.lua`: MVP integration modules.
- `lua/lualine/themes/vulkanite.lua`: lualine native theme export.
- `test/minimal_init.lua`: adds repo to runtimepath for headless tests.
- `test/vulkanite_spec.lua`: behavior tests.

Modify:

- `README.md`: new name, install docs for lazy.nvim and vim.pack, setup defaults, integration table.
- `colors/vulkan-colors.lua`: compatibility entrypoint can remain as a hard alias only if it loads Vulkanite and does not document the old name.
- `lua/vulkan-colors/*`: remove after clean cutover unless retained only because tests prove no stale public path remains. Prefer deletion.

---

### Task 1: Test Harness and Public API Red Tests

**Files:**
- Create: `test/minimal_init.lua`
- Create: `test/vulkanite_spec.lua`

- [ ] **Step 1: Create the minimal Neovim test init**

```lua
vim.opt.runtimepath:prepend(vim.fn.getcwd())
vim.opt.runtimepath:append(vim.fn.getcwd() .. "/after")
```

- [ ] **Step 2: Create failing public API tests**

```lua
local function assert_eq(actual, expected, message)
  if actual ~= expected then
    error((message or "assertion failed") .. ": expected " .. vim.inspect(expected) .. ", got " .. vim.inspect(actual), 2)
  end
end

local function assert_truthy(value, message)
  if not value then
    error(message or "expected truthy value", 2)
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
end

reset_vulkanite()
local vulkanite = require("vulkanite")
assert_eq(type(vulkanite.setup), "function", "setup exists")
assert_eq(type(vulkanite.load), "function", "load exists")
assert_eq(type(require("vulkanite.palette").get), "function", "palette get exists")

vulkanite.setup({})
vim.cmd.colorscheme("vulkanite")
assert_eq(vim.g.colors_name, "vulkanite", "colorscheme name")
assert_truthy(vim.api.nvim_get_hl(0, { name = "Normal" }).fg, "Normal fg set")
assert_truthy(vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg, "DiagnosticError fg set")
```

- [ ] **Step 3: Run the test and verify RED**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: FAIL because module `vulkanite` or colorscheme `vulkanite` does not exist.

- [ ] **Step 4: Commit the red tests**

```bash
git add test/minimal_init.lua test/vulkanite_spec.lua
git commit -m "test: add vulkanite public API smoke test"
```

---

### Task 2: Core Vulkanite Runtime

**Files:**
- Create: `colors/vulkanite.lua`
- Create: `lua/vulkanite/init.lua`
- Create: `lua/vulkanite/config.lua`
- Create: `lua/vulkanite/palette.lua`
- Create: `lua/vulkanite/colors.lua`
- Create: `lua/vulkanite/theme.lua`
- Modify: `test/vulkanite_spec.lua`

- [ ] **Step 1: Extend tests for options and override behavior**

Append to `test/vulkanite_spec.lua`:

```lua
reset_vulkanite()
require("vulkanite").setup({ terminal_colors = false })
vim.cmd.colorscheme("vulkanite")
assert_eq(vim.g.terminal_color_0, nil, "terminal colors disabled")

reset_vulkanite()
require("vulkanite").setup({
  transparent = true,
  on_colors = function(colors)
    colors.error = "#ff0000"
  end,
  on_highlights = function(highlights, colors)
    highlights.VulkaniteOverrideProbe = { fg = colors.error }
  end,
})
vim.cmd.colorscheme("vulkanite")
assert_eq(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, nil, "transparent Normal bg")
assert_eq(vim.api.nvim_get_hl(0, { name = "VulkaniteOverrideProbe" }).fg, tonumber("ff0000", 16), "highlight override applied")
```

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: FAIL because the runtime modules do not exist or options are ignored.

- [ ] **Step 3: Implement `colors/vulkanite.lua`**

```lua
require("vulkanite").load()
```

- [ ] **Step 4: Implement `lua/vulkanite/palette.lua`**

```lua
local palette = {
  bg = "#0f1416",
  bg_alt = "#151b1e",
  bg_float = "#151b1e",
  fg = "#f8fdff",
  fg_dim = "#abb2bf",
  comment = "#8e969a",
  gutter = "#5c6370",
  red = "#e05f64",
  orange = "#e08a64",
  yellow = "#8fe0fa",
  green = "#8be086",
  cyan = "#567e96",
  blue = "#8fe0fa",
  teal = "#37868b",
  purple = "#7b78aa",
}

local M = {}

function M.get()
  return vim.deepcopy(palette)
end

return M
```

- [ ] **Step 5: Implement `lua/vulkanite/config.lua`**

```lua
local M = {}

M.defaults = {
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

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
  return M.options
end

function M.extend(opts)
  if opts then
    return vim.tbl_deep_extend("force", vim.deepcopy(M.options), opts)
  end
  return vim.deepcopy(M.options)
end

return M
```

- [ ] **Step 6: Implement `lua/vulkanite/colors.lua`**

```lua
local M = {}

function M.setup(opts)
  local p = require("vulkanite.palette").get()
  local colors = vim.tbl_deep_extend("force", p, {
    bg_sidebar = p.bg_alt,
    bg_statusline = p.bg_alt,
    border = p.gutter,
    border_highlight = p.cyan,
    error = p.red,
    warning = p.orange,
    info = p.blue,
    hint = p.teal,
    ok = p.green,
    diff = {
      add = p.green,
      change = p.blue,
      delete = p.red,
      text = p.cyan,
    },
    git = {
      add = p.green,
      change = p.blue,
      delete = p.red,
      ignore = p.gutter,
    },
    terminal = {
      black = p.bg,
      red = p.red,
      green = p.green,
      yellow = p.orange,
      blue = p.blue,
      magenta = p.purple,
      cyan = p.cyan,
      white = p.fg_dim,
      bright_black = p.gutter,
      bright_red = p.red,
      bright_green = p.green,
      bright_yellow = p.yellow,
      bright_blue = p.blue,
      bright_magenta = p.purple,
      bright_cyan = p.teal,
      bright_white = p.fg,
    },
    rainbow = { p.red, p.orange, p.yellow, p.green, p.cyan, p.blue, p.purple },
  })
  if opts.transparent then
    colors.bg_sidebar = nil
    colors.bg_statusline = nil
  end
  opts.on_colors(colors)
  return colors
end

return M
```

- [ ] **Step 7: Implement `lua/vulkanite/init.lua` and `theme.lua` minimally**

`lua/vulkanite/init.lua`:

```lua
local config = require("vulkanite.config")

local M = {}

M.setup = config.setup

function M.load(opts)
  return require("vulkanite.theme").setup(config.extend(opts))
end

return M
```

`lua/vulkanite/theme.lua`:

```lua
local M = {}

local function set(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.terminal(colors)
  vim.g.terminal_color_0 = colors.terminal.black
  vim.g.terminal_color_1 = colors.terminal.red
  vim.g.terminal_color_2 = colors.terminal.green
  vim.g.terminal_color_3 = colors.terminal.yellow
  vim.g.terminal_color_4 = colors.terminal.blue
  vim.g.terminal_color_5 = colors.terminal.magenta
  vim.g.terminal_color_6 = colors.terminal.cyan
  vim.g.terminal_color_7 = colors.terminal.white
  vim.g.terminal_color_8 = colors.terminal.bright_black
  vim.g.terminal_color_9 = colors.terminal.bright_red
  vim.g.terminal_color_10 = colors.terminal.bright_green
  vim.g.terminal_color_11 = colors.terminal.bright_yellow
  vim.g.terminal_color_12 = colors.terminal.bright_blue
  vim.g.terminal_color_13 = colors.terminal.bright_magenta
  vim.g.terminal_color_14 = colors.terminal.bright_cyan
  vim.g.terminal_color_15 = colors.terminal.bright_white
end

function M.setup(opts)
  local colors = require("vulkanite.colors").setup(opts)
  local groups = require("vulkanite.groups").setup(colors, opts)

  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "vulkanite"

  opts.on_highlights(groups, colors)

  for group, hl in pairs(groups) do
    set(group, type(hl) == "string" and { link = hl } or hl)
  end

  if opts.terminal_colors then
    M.terminal(colors)
  end

  return colors, groups, opts
end

return M
```

- [ ] **Step 8: Run tests and verify they still fail only because groups are missing**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: FAIL because `vulkanite.groups` is not implemented.

- [ ] **Step 9: Commit runtime skeleton**

```bash
git add colors/vulkanite.lua lua/vulkanite/init.lua lua/vulkanite/config.lua lua/vulkanite/palette.lua lua/vulkanite/colors.lua lua/vulkanite/theme.lua test/vulkanite_spec.lua
git commit -m "feat: add vulkanite runtime skeleton"
```

---

### Task 3: Core Highlight Groups

**Files:**
- Create: `lua/vulkanite/groups/init.lua`
- Create: `lua/vulkanite/groups/base.lua`
- Create: `lua/vulkanite/groups/treesitter.lua`
- Create: `lua/vulkanite/groups/semantic_tokens.lua`
- Create: `lua/vulkanite/groups/kinds.lua`
- Modify: `test/vulkanite_spec.lua`

- [ ] **Step 1: Extend tests for core highlights**

Append to `test/vulkanite_spec.lua`:

```lua
reset_vulkanite()
require("vulkanite").setup({})
vim.cmd.colorscheme("vulkanite")
assert_truthy(vim.api.nvim_get_hl(0, { name = "@function" }).link == "Function" or vim.api.nvim_get_hl(0, { name = "@function" }).fg, "treesitter function set")
assert_truthy(vim.api.nvim_get_hl(0, { name = "@lsp.type.function" }).link == "Function" or vim.api.nvim_get_hl(0, { name = "@lsp.type.function" }).fg, "semantic function set")
assert_truthy(vim.api.nvim_get_hl(0, { name = "LspKindFunction" }).fg, "kind function set")
```

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: FAIL because core groups are not implemented.

- [ ] **Step 3: Implement `groups/base.lua`**

Use the existing `lua/vulkan-colors/init.lua` highlight intent as the source, translated to semantic `colors` names. Include editor UI, syntax, diagnostics, diff, LSP reference/inlay hint groups, and `GitSigns*` only if no plugin module owns them yet.

- [ ] **Step 4: Implement `groups/treesitter.lua`**

Return Tree-sitter captures linking to base syntax groups: comments, constants, strings, numbers, booleans, functions, keywords, operators, punctuation, types, variables, properties, constructors, tags, modules, labels.

- [ ] **Step 5: Implement `groups/semantic_tokens.lua`**

Return semantic token groups for functions, methods, variables, parameters, properties, types, classes, namespaces, keywords, comments, strings, numbers, operators, decorators, and readonly/defaultLibrary variants where useful.

- [ ] **Step 6: Implement `groups/kinds.lua`**

Expose `M.kinds(ret, pattern)` that fills completion kind groups using `string.format(pattern, kind)` for Text, Method, Function, Constructor, Field, Variable, Class, Interface, Module, Property, Unit, Value, Enum, Keyword, Snippet, Color, File, Reference, Folder, EnumMember, Constant, Struct, Event, Operator, TypeParameter.

- [ ] **Step 7: Implement `groups/init.lua` with core modules only**

Merge `base`, `treesitter`, `semantic_tokens`, and a generated `LspKind%s` table through `kinds`.

- [ ] **Step 8: Run tests and verify GREEN**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: PASS.

- [ ] **Step 9: Run formatter**

Run:

```bash
stylua colors lua test
```

Expected: no output and exit 0.

- [ ] **Step 10: Commit core groups**

```bash
git add lua/vulkanite/groups test/vulkanite_spec.lua
git commit -m "feat: add vulkanite core highlight groups"
```

---

### Task 4: Plugin Integration Registry and MVP Integrations

**Files:**
- Modify: `lua/vulkanite/groups/init.lua`
- Create: `lua/vulkanite/groups/integrations/gitsigns.lua`
- Create: `lua/vulkanite/groups/integrations/telescope.lua`
- Create: `lua/vulkanite/groups/integrations/cmp.lua`
- Create: `lua/vulkanite/groups/integrations/blink.lua`
- Create: `lua/vulkanite/groups/integrations/which_key.lua`
- Create: `lua/vulkanite/groups/integrations/lazy.lua`
- Create: `lua/vulkanite/groups/integrations/neo_tree.lua`
- Create: `lua/vulkanite/groups/integrations/nvim_tree.lua`
- Create: `lua/vulkanite/groups/integrations/noice.lua`
- Create: `lua/vulkanite/groups/integrations/notify.lua`
- Create: `lua/vulkanite/groups/integrations/snacks.lua`
- Create: `lua/vulkanite/groups/integrations/treesitter_context.lua`
- Create: `lua/vulkanite/groups/integrations/render_markdown.lua`
- Modify: `test/vulkanite_spec.lua`

- [ ] **Step 1: Add tests for manual toggles and auto-detection**

Append to `test/vulkanite_spec.lua`:

```lua
reset_vulkanite()
require("vulkanite").setup({ plugins = { auto = false, all = false, snacks = true, telescope = false } })
vim.cmd.colorscheme("vulkanite")
assert_truthy(vim.api.nvim_get_hl(0, { name = "SnacksPickerMatch" }).fg, "manual snacks enabled")
assert_eq(vim.api.nvim_get_hl(0, { name = "TelescopeMatching" }).fg, nil, "manual telescope disabled")

reset_vulkanite()
package.loaded["lazy.core.config"] = {
  plugins = {
    ["folke/snacks.nvim"] = {},
  },
}
package.loaded.lazy = {}
require("vulkanite").setup({ plugins = { auto = true, all = false, snacks = false } })
vim.cmd.colorscheme("vulkanite")
assert_eq(vim.api.nvim_get_hl(0, { name = "SnacksPickerMatch" }).fg, nil, "manual false beats lazy auto")
package.loaded["lazy.core.config"] = nil
package.loaded.lazy = nil

reset_vulkanite()
local original_pack = vim.pack
vim.pack = {
  get = function()
    return {
      { spec = { name = "snacks.nvim", src = "https://github.com/folke/snacks.nvim" } },
    }
  end,
}
require("vulkanite").setup({ plugins = { auto = true, all = false } })
vim.cmd.colorscheme("vulkanite")
assert_truthy(vim.api.nvim_get_hl(0, { name = "SnacksPickerMatch" }).fg, "vim.pack auto enables snacks")
vim.pack = original_pack
```

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: FAIL because integration loading and plugin modules do not exist.

- [ ] **Step 3: Implement registry and detection in `groups/init.lua`**

Add registry entries for Lazy/nvim-pack names and manual keys. Auto-detect lazy via `package.loaded.lazy` and `require("lazy.core.config").plugins`. Auto-detect vim.pack via `vim.pack.get(nil, { info = false })`; match both `spec.name` and `spec.src` substrings. Manual booleans override detected values.

- [ ] **Step 4: Implement simple integration modules**

Each module must define `M.url` and `M.get(colors, opts)`. Use semantic colors only. Prefer links to core groups when possible. `snacks.lua` must include notifier, dashboard, indent, picker, input, profiler, GitHub/diff labels, and `SnacksIndent1..7` generated from `colors.rainbow`.

- [ ] **Step 5: Run tests and verify GREEN**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: PASS.

- [ ] **Step 6: Run formatter**

Run:

```bash
stylua colors lua test
```

Expected: no output and exit 0.

- [ ] **Step 7: Commit integrations**

```bash
git add lua/vulkanite/groups test/vulkanite_spec.lua
git commit -m "feat: add vulkanite MVP integrations"
```

---

### Task 5: Lualine Theme and Brand Cutover

**Files:**
- Create: `lua/lualine/themes/vulkanite.lua`
- Modify: `test/vulkanite_spec.lua`
- Modify/Delete: `colors/vulkan-colors.lua`
- Delete: `lua/vulkan-colors/init.lua`
- Delete: `lua/vulkan-colors/palette.lua`

- [ ] **Step 1: Add lualine and stale-path tests**

Append to `test/vulkanite_spec.lua`:

```lua
local lualine = require("lualine.themes.vulkanite")
assert_truthy(lualine.normal and lualine.normal.a and lualine.normal.a.bg, "lualine normal mode exists")
assert_truthy(lualine.insert and lualine.insert.a and lualine.insert.a.bg, "lualine insert mode exists")
assert_eq(package.loaded["vulkan-colors"], nil, "old module not loaded")
```

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: FAIL because lualine theme does not exist.

- [ ] **Step 3: Implement `lua/lualine/themes/vulkanite.lua`**

Return a lualine table using `require("vulkanite.colors").setup(require("vulkanite.config").extend())` with normal/insert/command/visual/replace/terminal/inactive sections.

- [ ] **Step 4: Remove old public module files**

Delete `lua/vulkan-colors/init.lua` and `lua/vulkan-colors/palette.lua`. Keep `colors/vulkan-colors.lua` only if it is a tiny compatibility alias to `require("vulkanite").load()`; otherwise delete it. Do not document the old name.

- [ ] **Step 5: Run tests and verify GREEN**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: PASS.

- [ ] **Step 6: Run formatter**

Run:

```bash
stylua colors lua test
```

Expected: no output and exit 0.

- [ ] **Step 7: Commit lualine and cutover**

```bash
git add colors lua test/vulkanite_spec.lua
git commit -m "feat: add lualine theme and vulkanite cutover"
```

---

### Task 6: README and Final Verification

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Rewrite README for Vulkanite MVP**

README must include: identity statement, requirements, lazy.nvim install, native `vim.pack.add()` install, usage, setup defaults, integrations table including Snacks, lualine snippet, override examples, palette export example, local development snippet.

- [ ] **Step 2: Run smoke tests**

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Expected: PASS.

- [ ] **Step 3: Run direct colorscheme smoke**

Run:

```bash
nvim --headless -u NONE -c 'set rtp^=.' -c 'colorscheme vulkanite' -c 'lua assert(vim.g.colors_name == "vulkanite")' -c 'qa'
```

Expected: no output and exit 0.

- [ ] **Step 4: Run formatter**

Run:

```bash
stylua colors lua test
```

Expected: no output and exit 0.

- [ ] **Step 5: Commit docs and verification updates**

```bash
git add README.md
git commit -m "docs: document vulkanite MVP surface"
```

---

## Final verification

Run:

```bash
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
nvim --headless -u NONE -c 'set rtp^=.' -c 'colorscheme vulkanite' -c 'lua assert(vim.g.colors_name == "vulkanite")' -c 'qa'
stylua colors lua test --check
```

Expected: all commands exit 0 with no errors.
