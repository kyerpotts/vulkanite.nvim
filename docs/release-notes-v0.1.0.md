# Vulkanite v0.1.0 release notes (draft)

Vulkanite is a dark Neovim colorscheme built around coral-red values, cool blue and teal structure, and typography that remains consistent across Tree-sitter and LSP semantic tokens.

## Visual identity

- Coral-red variables, parameters, literals, and value-like symbols.
- Bright-teal properties and members.
- Bold purple constants and enum members.
- Upright green strings and yellow documentation strings.
- Bold dark-teal keywords and control flow.
- Upright bright-blue functions and methods.
- Italic sky-blue types, classes, structs, interfaces, enums, and aliases.
- Light-grey operators and punctuation.
- Muted-blue escapes, regular expressions, decorators, and special syntax.
- Italic grey comments and documentation.
- Dedicated vivid-red errors, yellow warnings and documentation strings, and purple icons.

## Editor and plugin support

The initial release includes editor UI, diagnostics, diffs, Tree-sitter captures, LSP semantic tokens, completion kinds, terminal colors, and a bundled lualine theme.

Bundled integrations cover:

- gitsigns.nvim
- telescope.nvim
- nvim-cmp
- blink.cmp
- which-key.nvim
- lazy.nvim
- neo-tree.nvim
- nvim-tree.lua
- noice.nvim
- nvim-notify
- snacks.nvim
- nvim-treesitter-context
- render-markdown.nvim

Integrations support explicit toggles and automatic detection through lazy.nvim or `vim.pack` when available.

## Configuration

Vulkanite supports:

- Transparent editor backgrounds.
- Optional ANSI terminal colors.
- Configurable comment, keyword, function, type, constant, string, and variable styles.
- `on_colors` overrides before semantic roles are derived.
- `on_highlights` overrides before highlights are applied.
- A public named palette and a complete nested Base16 mapping.

## Compatibility

The colorscheme entry point is `vulkanite`. The legacy `vulkan-colors` colorscheme name remains available as a compatibility alias for this release, pending a final compatibility decision.

## Before publishing

Replace this section with the final minimum Neovim version, canonical repository URL, license, screenshot links, and any known integration version requirements.
