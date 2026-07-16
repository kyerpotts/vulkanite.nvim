# Vulkanite

## Identity

Vulkanite is a dark Neovim colorscheme with coral-heavy values, cool blue and teal structure, and typography that distinguishes functions, types, and comments.

Release screenshot fixtures are available in [`demo/`](demo/README.md).

## Requirements

- Neovim with true color support.
- A plugin manager, or native `vim.pack` on modern Neovim versions where it is available.

## Installation with lazy.nvim

```lua
{
  "squidmilk/vulkanite.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vulkanite").setup({})
    vim.cmd.colorscheme("vulkanite")
  end,
}
```

## Installation with LazyVim

LazyVim users should let LazyVim own the final colorscheme load. Calling
`vim.cmd.colorscheme("vulkanite")` only from the colorscheme plugin spec can be
overwritten later by LazyVim's configured default theme.

Place this in `lua/plugins/vulkanite.lua`:

```lua
return {
  {
    "squidmilk/vulkanite.nvim",
    lazy = false,
    priority = 1000,
    main = "vulkanite",
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vulkanite",
    },
  },
}
```

For visual QA, force every bundled integration on while testing:

```lua
return {
  {
    "squidmilk/vulkanite.nvim",
    lazy = false,
    priority = 1000,
    main = "vulkanite",
    opts = {
      plugins = { all = true },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vulkanite",
    },
  },
}
```

## Installation with native `vim.pack.add()`

```lua
vim.pack.add({
  { src = "https://github.com/squidmilk/vulkanite.nvim" },
})

require("vulkanite").setup({})
vim.cmd.colorscheme("vulkanite")
```

## Local development install

For LazyVim local testing, use the worktree or checkout path and still set
`LazyVim/LazyVim.opts.colorscheme`:

```lua
return {
  {
    dir = "/path/to/vulkanite.nvim",
    name = "vulkanite.nvim",
    lazy = false,
    priority = 1000,
    main = "vulkanite",
    opts = {
      plugins = { all = true },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vulkanite",
    },
  },
}
```

## Usage

```vim
colorscheme vulkanite
```

Lua form:

```lua
vim.cmd.colorscheme("vulkanite")
```

Configure before loading the colorscheme:

```lua
require("vulkanite").setup({
  transparent = true,
})
vim.cmd.colorscheme("vulkanite")
```

## Setup defaults

```lua
require("vulkanite").setup({
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = { italic = true },
    types = { bold = true },
    constants = { bold = true },
    strings = {},
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
})
```

Style tables are deep-merged with these defaults. To disable a default style,
set it explicitly to `false`, for example:

```lua
require("vulkanite").setup({
  styles = {
    comments = { italic = false },
    functions = { italic = false },
    types = { bold = false },
    constants = { bold = false },
  },
})
```

## Supported integrations

Bundled integrations default to `"auto"`: Vulkanite enables them when `lazy.nvim` or `vim.pack` reports a matching installed plugin. Explicit `true` or `false` values take precedence over all other settings. Otherwise, `plugins.all = true` enables the integration, followed by package-manager detection when `plugins.auto = true`. Set `plugins.auto = false` to disable detection.

| Plugin | Key | Note |
| --- | --- | --- |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `gitsigns` | Git add, change, delete, staged, and untracked indicators. |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | `telescope` | Picker, prompt, preview, and selection highlights. |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | `cmp` | Completion menu and item kind highlights. |
| [blink.cmp](https://github.com/saghen/blink.cmp) | `blink` | Completion menu and documentation highlights. |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | `which_key` | Which-key popup highlights. |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | `lazy` | Lazy plugin manager UI highlights. |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | `neo_tree` | Neo-tree file explorer highlights. |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | `nvim_tree` | Nvim-tree file explorer highlights. |
| [noice.nvim](https://github.com/folke/noice.nvim) | `noice` | Command line, popup, and message UI highlights. |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | `notify` | Notification title, border, and icon highlights. |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | `snacks` | Dashboard, picker, notifier, input, and indent highlights. |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | `treesitter_context` | Sticky context and line-number highlights. |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | `render_markdown` | Headings, code, lists, quotes, rules, and tables. |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | `lualine` | Use the bundled `vulkanite` lualine theme. |

## Lualine

Load Vulkanite before configuring lualine so the bundled theme can reuse resolved `on_colors` overrides. The recommended eager colorscheme installation snippets above provide this ordering.

```lua
require("lualine").setup({
  options = { theme = "vulkanite" },
})
```

## Overrides

### Override colors

`on_colors` runs once per colorscheme load and receives the resolved public color table before internal semantic roles and highlights are generated. Requiring the bundled lualine theme does not invoke it.

```lua
require("vulkanite").setup({
  on_colors = function(colors)
    colors.accent = "#8be086"
    colors.bg_float = "#1b2327"
  end,
})
```

Supported public color keys are:

- UI: `bg`, `bg_alt`, `bg_float`, `fg`, `fg_bright`, `fg_dim`, `comment`, `gutter`, and `selection`.
- Syntax and accents: `value`, `docstring`, `accent`, `sky_blue`, `teal`, `bright_teal`, `purple`, and `ok`.
- Diagnostics: `error`, `warn`, `info`, and `hint`.
- Terminal: `terminal`, a 16-entry ANSI color array.

`colors.roles` is derived after `on_colors` returns and is internal to highlight generation. Override the public keys above rather than mutating internal roles.

### Override highlights

`on_highlights` receives the highlight table and the resolved colors before highlights are applied.

```lua
require("vulkanite").setup({
  on_highlights = function(highlights, colors)
    highlights.NormalFloat = { fg = colors.fg, bg = colors.bg }
    highlights.CursorLine = { bg = colors.bg_alt }
  end,
})
```

## Palette

![Vulkanite authored palette](assets/palette.svg)

```lua
local palette = require("vulkanite.palette").get()
```

The public palette contains exactly 16 authored colors, named for their visual
appearance rather than their Base16 roles:

| Name | Hex | Name | Hex |
| --- | --- | --- | --- |
| `dark_black` | `#0f1416` | `soft_black` | `#151b1e` |
| `slate_grey` | `#5c6370` | `comment_grey` | `#8e969a` |
| `light_grey` | `#abb2bf` | `pale_grey` | `#dce5e9` |
| `coral_red` | `#e05f64` | `vivid_red` | `#e03f32` |
| `yellow` | `#e0af68` | `sky_blue` | `#76c7e3` |
| `bright_green` | `#8be086` | `bright_blue` | `#8fe0fa` |
| `muted_blue` | `#567e96` | `dark_teal` | `#37868b` |
| `bright_teal` | `#4fa3a6` | `purple` | `#9083B9` |

A complete Base16 compatibility mapping remains available under `palette.base16`. Compatibility roles may intentionally reuse an authored color:

```lua
palette.base16.base00 == palette.dark_black
palette.base16.base0A == palette.sky_blue
palette.base16.base0D == palette.bright_blue
```

The default syntax identity keeps variables, parameters, and literals coral red;
properties and members in the bright foreground; constants bold purple; strings green; documentation
strings and warnings yellow; keywords upright dark teal; functions italic bright blue; types
bold upright sky blue; constructors bold italic sky blue; operators in the bright foreground;
punctuation light grey; special syntax muted blue; and comments
grey and italic.
