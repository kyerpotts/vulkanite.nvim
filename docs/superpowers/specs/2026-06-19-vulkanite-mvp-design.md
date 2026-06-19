# Vulkanite MVP Design

## Goal

Turn the current `vulkan-colors.nvim` repository into `vulkanite.nvim`: a modern Neovim colorscheme that feels credible to LazyVim-style `lazy.nvim` users and native `vim.pack` users without copying the full breadth of Catppuccin or TokyoNight.

## Target users

Primary users:

- Modern Neovim users who install startup colorschemes through `lazy.nvim` with `lazy = false` and `priority = 1000`.
- Modern Neovim users who install plugins through Neovim's native `vim.pack.add()`.
- Users who expect common plugins to look intentional immediately: completion, picker, git signs, notifications, dashboards, statusline, and modern Tree-sitter/LSP highlighting.

Non-goals for the MVP:

- Reaching Catppuccin/TokyoNight plugin-count parity.
- Supporting Vim.
- Shipping a compile cache.
- Shipping generated themes for dozens of external applications.
- Shipping multiple named flavours before the base theme identity is stable.

## Product characteristics

The MVP must be:

- Discoverable: installation, setup, palette access, and integration support must be obvious from the README.
- Conventional: the public API should match patterns users already know from TokyoNight and Catppuccin.
- Modular: integrations must be small files with one contract so future coverage can grow without turning `init.lua` into a registry dump.
- Manager-neutral: the plugin must work without `lazy.nvim`; `lazy.nvim` and `vim.pack` receive first-class install docs and auto-detection support where practical.
- Customizable at the boundary: users must be able to override colors and highlights without forking.

## Public API

The public module name is `vulkanite`.

```lua
require("vulkanite").setup({
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
    snacks = true,
  },
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
})

vim.cmd.colorscheme("vulkanite")
```

Required entry points:

- `colors/vulkanite.lua` loads the colorscheme.
- `require("vulkanite").setup(opts)` stores user configuration.
- `require("vulkanite").load(opts)` computes and applies highlights.
- `require("vulkanite.palette").get()` returns the public palette table.
- `require("vulkanite.colors").setup(opts)` returns derived semantic colors.

## Installation surface

README must include both first-class install paths.

`lazy.nvim`:

```lua
{
  "squidmilk/vulkanite.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("vulkanite").setup(opts)
    vim.cmd.colorscheme("vulkanite")
  end,
}
```

Native `vim.pack`:

```lua
vim.pack.add({
  { src = "https://github.com/squidmilk/vulkanite.nvim" },
})

require("vulkanite").setup({})
vim.cmd.colorscheme("vulkanite")
```

The runtime layout remains standard Neovim colorscheme layout, so either manager can load it through the runtime path.

## Internal architecture

The monolithic highlight table moves into focused modules:

```text
colors/vulkanite.lua
lua/vulkanite/init.lua
lua/vulkanite/config.lua
lua/vulkanite/palette.lua
lua/vulkanite/colors.lua
lua/vulkanite/theme.lua
lua/vulkanite/groups/init.lua
lua/vulkanite/groups/base.lua
lua/vulkanite/groups/treesitter.lua
lua/vulkanite/groups/semantic_tokens.lua
lua/vulkanite/groups/kinds.lua
lua/vulkanite/groups/integrations/*.lua
lua/lualine/themes/vulkanite.lua
```

Responsibilities:

- `config.lua`: defaults and deep-merge logic.
- `palette.lua`: raw Vulkanite color identity.
- `colors.lua`: semantic aliases and derived colors such as `bg_float`, `border`, `error`, `warning`, `git.add`, `terminal`, and `rainbow`.
- `theme.lua`: clear old highlights, set `termguicolors`, set `colors_name`, apply groups, set terminal colors when enabled.
- `groups/init.lua`: collect always-on core groups and enabled integration groups.
- `groups/base.lua`: editor UI, syntax, diagnostics, diff, LSP references, inlay hints.
- `groups/treesitter.lua`: modern Tree-sitter captures.
- `groups/semantic_tokens.lua`: LSP semantic token groups.
- `groups/kinds.lua`: reusable completion/LSP kind color mapping.
- `groups/integrations/*.lua`: one plugin integration per file.

## Integration contract

Each integration module follows one shape:

```lua
local M = {}

M.url = "https://github.com/example/plugin.nvim"

function M.get(colors, opts)
  return {
    ExampleGroup = { fg = colors.fg, bg = colors.bg_float },
  }
end

return M
```

`groups/init.lua` owns a registry mapping manager plugin names to integration keys:

```lua
{
  ["lewis6991/gitsigns.nvim"] = "gitsigns",
  ["nvim-telescope/telescope.nvim"] = "telescope",
  ["hrsh7th/nvim-cmp"] = "cmp",
  ["Saghen/blink.cmp"] = "blink",
  ["folke/which-key.nvim"] = "which_key",
  ["folke/lazy.nvim"] = "lazy",
  ["folke/snacks.nvim"] = "snacks",
}
```

Auto-detection behavior:

- If `lazy.nvim` is loaded, inspect `require("lazy.core.config").plugins`.
- If `vim.pack` is available, inspect `vim.pack.get(nil, { info = false })` and match `spec.name` and `spec.src` where available.
- Manual `plugins.<name>` values override auto-detection.
- `plugins.all = true` enables every bundled integration.
- `plugins.auto = false` disables manager detection.

This keeps native `vim.pack` users from being second-class while avoiding a hard dependency on any manager.

## MVP integration list

The first release ships these integrations:

- `gitsigns.nvim`: git add/change/delete signs.
- `telescope.nvim`: picker borders, prompts, matches, selection.
- `nvim-cmp`: completion menu, matches, docs, kind colors.
- `blink.cmp`: completion menu and kind colors for modern LazyVim-style setups.
- `which-key.nvim`: key popup groups.
- `lazy.nvim`: plugin manager UI groups.
- `neo-tree.nvim`: file tree groups.
- `nvim-tree.lua`: file tree groups for users not on neo-tree.
- `noice.nvim`: command/message UI groups.
- `nvim-notify`: notification severity groups.
- `folke/snacks.nvim`: notifier, dashboard, picker, indent, input, profiler, and GitHub/diff labels.
- `nvim-treesitter-context`: sticky context and line number groups.
- `render-markdown.nvim`: markdown rendering groups.
- `lualine.nvim`: native `lua/lualine/themes/vulkanite.lua` theme export.

Snacks is included because it increasingly acts as a bundle of modern UI surfaces: picker, notifier, dashboard, input, indent, profiler, and utility views. Vulkanite should support it as one first-class integration instead of treating each surface as future cleanup.

## Lualine export

`lua/lualine/themes/vulkanite.lua` returns a normal lualine theme table with mode-specific `a`, `b`, and `c` sections:

- normal: primary blue/cyan accent.
- insert: green accent.
- command: cyan or warning accent.
- visual: teal accent.
- replace: red accent.
- terminal: green accent.
- inactive: dim foreground on statusline background.

This is a high-value integration because users configure lualine by theme name rather than highlight groups.

## Documentation surface

README must contain:

- Short identity statement for Vulkanite.
- Screenshot section.
- Requirements: modern Neovim, with native `vim.pack` support when available.
- `lazy.nvim` install snippet.
- `vim.pack.add()` install snippet.
- Usage with `vim.cmd.colorscheme("vulkanite")`.
- Setup defaults block.
- Supported integrations table with plugin links and config keys.
- Color/highlight override examples.
- Palette export example.
- Local development install snippet.

Generated vimdoc is deferred until the README stabilizes.

## Testing and verification

The implementation should include lightweight tests or checks that verify:

- `require("vulkanite").setup({})` succeeds.
- `vim.cmd.colorscheme("vulkanite")` sets `vim.g.colors_name` to `vulkanite`.
- Core highlight groups are applied.
- `transparent = true` suppresses background where intended.
- `terminal_colors = false` does not write terminal color globals.
- `on_colors` can mutate semantic colors before groups are generated.
- `on_highlights` can override a highlight before application.
- Manual plugin toggles enable and disable integration groups.
- `plugins.auto` can detect lazy.nvim and vim.pack plugin records without requiring either manager.
- `lua/lualine/themes/vulkanite.lua` returns a valid lualine mode table.

## Deferred mature surface

Defer until after the MVP is stable:

- Compile cache and hash invalidation.
- Generated vimdoc.
- External terminal/tool extras beyond possible hand-written examples.
- Lightline, barbecue, bufferline, feline, and other special theme adapters.
- Broad mini.nvim module coverage.
- Full plugin table generation.
- Multiple flavours.
- Vim support.

## Acceptance criteria

The MVP is complete when:

- Users can install Vulkanite through `lazy.nvim` or `vim.pack.add()` using README snippets.
- `colorscheme vulkanite` works without calling setup.
- Calling setup before colorscheme load customizes styles, transparency, terminal colors, plugin integrations, and color/highlight overrides.
- The integration modules listed above are implemented and documented.
- Lazy.nvim and vim.pack users can use automatic integration detection where the manager exposes enough metadata.
- Lualine can use `theme = "vulkanite"`.
- The README makes the supported surface clear without implying Catppuccin/TokyoNight-scale breadth.
