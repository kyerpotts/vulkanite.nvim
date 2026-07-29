# Vulkanite v0.1.1 release notes

Vulkanite v0.1.1 improves active-tab visibility and gives LSP-tagged unnecessary code a quieter, dedicated presentation.

## Highlights

- Active native Neovim tabs now use Vulkanite's secondary teal accent.
- Clean selected buffers in bufferline.nvim use the same secondary accent while retaining bold and italic styling.
- Selected buffers with diagnostics continue to use their severity color, including vivid red for errors.
- Code tagged unnecessary by an LSP now uses subdued slate grey while preserving its underlying syntax styling and diagnostic undercurls.

## Integration and configuration

- Added automatic and explicit highlight integration for bufferline.nvim.
- Added `unnecessary` to the public `on_colors` interface so the diagnostic color can be overridden independently.

## Requirements

Vulkanite continues to require Neovim 0.10 or later with true-color support. The canonical repository is <https://github.com/kyerpotts/vulkanite.nvim>, and Vulkanite is released under the MIT License.
