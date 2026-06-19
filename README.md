# vulkan-colors.nvim

A standalone Neovim colorscheme built from the palette in `dankcolors.lua`.

## Install

### lazy.nvim

```lua
{
  "squidmilk/vulkan-colors.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("vulkan-colors")
  end,
}
```

For local development:

```lua
{
  dir = "/home/squidmilk/work/vulkan-colors.nvim",
  name = "vulkan-colors.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("vulkan-colors")
  end,
}
```

## Usage

```vim
colorscheme vulkan-colors
```

or Lua:

```lua
vim.cmd.colorscheme("vulkan-colors")
```

The palette is exposed for plugin integrations:

```lua
local colors = require("vulkan-colors.palette")
```
