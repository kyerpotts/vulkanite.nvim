# Vulkanite

## Identity

Vulkanite is a modern Neovim colorscheme.

## Requirements

- Neovim with true color support.
- A plugin manager, or native `vim.pack` on modern Neovim versions where it is available.

## Installation with lazy.nvim

For LazyVim-style setups, place this spec in a file such as `lua/plugins/vulkanite.lua`:

```lua
return {
  {
    "squidmilk/vulkanite.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("vulkanite").setup(opts)
      vim.cmd.colorscheme("vulkanite")
    end,
  },
}
```

If you keep plugin specs in a single list, use the inner table directly:

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

## Installation with native `vim.pack.add()`

```lua
vim.pack.add({
  { src = "https://github.com/squidmilk/vulkanite.nvim" },
})

require("vulkanite").setup({})
vim.cmd.colorscheme("vulkanite")
```

## Local development install

```lua
{
  dir = "/path/to/vulkanite.nvim",
  name = "vulkanite.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("vulkanite").setup(opts)
    vim.cmd.colorscheme("vulkanite")
  end,
}
```

Or replace `dir` with your local checkout path.

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
})
```

## Supported integrations

Bundled MVP integrations are enabled by default. Set a plugin key to `false` to disable that integration, set `plugins.auto = false` to skip package-manager detection, or set `plugins.all = true` to force every bundled integration on.

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
