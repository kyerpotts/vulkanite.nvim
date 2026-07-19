# Vulkanite v0.1.0 release notes

Vulkanite is a dark Neovim colorscheme built around coral-red values, cool blue and teal structure, and typography that remains consistent across Tree-sitter and LSP semantic tokens.

## Visual identity

- Coral-red variables, parameters, literals, and value-like symbols.
- Bright-teal properties and members.
- Bold purple constants and enum members.
- Upright green strings and yellow documentation strings.
- Upright dark-teal keywords and control flow.
- Italic bright-blue functions and methods.
- Bold upright sky-blue types, classes, structs, interfaces, enums, and aliases.
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

Vulkanite requires Neovim 0.10 or later with true-color support. Neovim 0.12
and later can install it through the experimental built-in `vim.pack`; earlier
supported versions require another plugin manager or a manual runtime-path installation.

The canonical repository is <https://github.com/kyerpotts/vulkanite.nvim>.
Vulkanite is released under the MIT License.

The colorscheme entry point is `vulkanite`. The legacy `vulkan-colors`
colorscheme name remains available as a compatibility alias for v0.1.0. The
public authored palette retains its British `grey` key spelling.

Integrations define highlight groups without imposing integration-specific
minimum plugin versions. Unsupported or renamed upstream groups are harmless
until the relevant plugin provides them.
