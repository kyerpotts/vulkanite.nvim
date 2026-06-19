# Vulkanite

## Identity

Vulkanite is a modern Neovim colorscheme.

## Requirements

- Neovim with true color support.
- A plugin manager, or native `vim.pack` on modern Neovim versions where it is available.

## Installation with LazyVim / lazy.nvim

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
})
```

## Supported integrations

Bundled MVP integrations default to `"auto"`: Vulkanite enables them when `lazy.nvim` or `vim.pack` reports a matching installed plugin. Set a plugin key to `true` or `false` to override detection, set `plugins.auto = false` to skip package-manager detection, or set `plugins.all = true` to force every bundled integration on.

| Plugin | Key | Note |
| --- | --- | --- |
| gitsigns.nvim | `gitsigns` | Git sign and inline blame highlights. |
| telescope.nvim | `telescope` | Picker, prompt, preview, and selection highlights. |
| nvim-cmp | `cmp` | Completion menu and item kind highlights. |
| blink.cmp | `blink` | Blink completion menu and documentation highlights. |
| which-key.nvim | `which_key` | Which-key popup highlights. |
| lazy.nvim | `lazy` | Lazy plugin manager UI highlights. |
| neo-tree.nvim | `neo_tree` | Neo-tree file explorer highlights. |
| nvim-tree.lua | `nvim_tree` | Nvim-tree file explorer highlights. |
| noice.nvim | `noice` | Command line, popup, and message UI highlights. |
| nvim-notify | `notify` | Notification title, border, and icon highlights. |
| snacks.nvim | `snacks` | Dashboard, picker, notifier, input, and indent highlights. |
| nvim-treesitter-context | `treesitter_context` | Treesitter context window highlights. |
| render-markdown.nvim | `render_markdown` | Rendered Markdown heading, code, checkbox, and callout highlights. |
| lualine.nvim | `lualine` | Use the bundled `vulkanite` lualine theme. |

## Lualine

```lua
require("lualine").setup({
  options = { theme = "vulkanite" },
})
```

## Overrides

### Override colors

`on_colors` receives the resolved color table before highlights are generated.

```lua
require("vulkanite").setup({
  on_colors = function(colors)
    colors.accent = "#8be086"
    colors.bg_float = "#151b1e"
  end,
})
```

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

```lua
local palette = require("vulkanite.palette").get()
```

The original `base00` through `base0F` roles are preserved and used for core
syntax mappings. Vulkanite also exports extended accents for selective UI
surfaces and user overrides:

```lua
palette.orange -- "#e08a64", warm accent
palette.purple -- "#7b78aa", snippet/icon accent
```
