# Vulkanite Public Release Checklist

This checklist tracks the work required before the first public Vulkanite release.
A task is complete only when its verification notes are satisfied.

## Current baseline

- [x] The palette exposes exactly 16 unique authored colors with a complete nested Base16 compatibility mapping.
- [x] The default syntax identity is documented in the README.
- [x] Functions and strings are upright, types and comments are italic, and constants are bold.
- [x] Variables and value-like symbols retain the coral-red visual identity.
- [x] The local headless test suite passes on Neovim 0.12.3.
- [x] The direct `colorscheme vulkanite` smoke test passes locally.
- [x] StyLua and `git diff --check` pass locally.

These checks must be rerun after every release-blocking change.

## 1. Release blockers

### License

- [ ] Choose the project license.
  - Proposed default: MIT.
- [ ] Add the license as `LICENSE` at the repository root.
- [ ] Mention the license in the README.

Verification:

- GitHub detects the selected license.
- The license owner and year are correct.

### Canonical repository identity

- [ ] Decide whether the canonical repository is `squidmilk/vulkanite.nvim` or `kyerpotts/vulkanite.nvim`.
- [ ] Update every installation URL to use the canonical owner.
- [ ] Update the Git remote if the current remote is not canonical.
- [ ] Search the repository for stale owner or repository names.

Verification:

```sh
rg -n 'squidmilk|kyerpotts|vulkan-colors|vulkanite\.nvim' .
```

All remaining references must be intentional, including the legacy colorscheme alias.

### Supported Neovim versions

- [ ] Select the minimum supported Neovim version.
- [ ] Verify the runtime and tests against that version.
- [ ] Document the minimum version in the README.
- [ ] Clarify which version first supports the documented `vim.pack` installation path.

Verification:

- CI passes on the minimum supported version.
- CI passes on the current stable version.
- Optional nightly failures do not conceal stable-version failures.

### Terminal color state

- [x] Clear `vim.g.terminal_color_0` through `vim.g.terminal_color_15` when reloading with `terminal_colors = false`.
- [x] Add a regression test that loads with terminal colors enabled and then reloads with them disabled.
- [x] Verify enabling terminal colors again restores all 16 values.

Verification:

- No terminal color from a previous Vulkanite load survives while the option is disabled.

### Screenshots

- [x] Add multi-language screenshot source fixtures under `demo/`.
- [ ] Add a primary screenshot showing the normal editing experience.
- [ ] Add at least one screenshot with completion, diagnostics, and a picker visible.
- [ ] Record the font, terminal, and relevant Neovim plugins used for the screenshots.
- [ ] Add the screenshots near the top of the README.
- [x] Add a hand-maintained palette swatch at `assets/palette.svg`.

Suggested language coverage:

- Rust
- Go
- TypeScript or JavaScript
- Python
- Markdown

## 2. Architecture and correctness

### Internal semantic color interface

- [x] Define nested UI, syntax, diagnostic, diff, and accent roles for core group modules.
- [x] Give integration modules a separate flat semantic adapter suited to plugin highlights.
- [x] Stop mixing flat and nested role fields within each group-module interface.
- [x] Keep raw authored palette names inside `palette.lua`.
- [x] Keep public `on_colors` overrides separate from internal group mapping policy.
- [x] Name the aggregate interface `roles` at the composition seam while retaining concise `colors` names inside leaf highlight factories.
- [x] Add tests for the stable public override interface and the internal role derivation seam.

Target invariant:

> Highlight group modules consume semantic roles; they do not choose directly from the raw palette.

Verification:

```sh
rg -n 'colors\.(dark_black|soft_black|coral_red|vivid_red|yellow|sky_blue|bright_blue|dark_teal|bright_teal)' lua/vulkanite/groups
```

The search should return no direct raw-palette coupling.

### Integration metadata

- [x] Derive integration module paths from their public configuration keys.
- [x] Derive repository detection metadata from each integration adapter's `M.url`.
- [x] Add contract tests for integration URLs and highlight factories.

Target invariant:

> Repository identity and URL are declared once in the integration adapter; the public key remains explicit in configuration and the registry.

### Pure color resolution and lualine

- [x] Prevent requiring `lualine.themes.vulkanite` from unexpectedly running `on_colors`.
- [x] Cache resolved colors for lualine after the colorscheme loads and use pure defaults before it loads.
- [x] Add a regression test counting callback invocations when both Vulkanite and the lualine theme are loaded.

Verification:

- `on_colors` runs only at the documented lifecycle point.
- Lualine loaded after Vulkanite reuses resolved overrides without rerunning callbacks.
- Loading lualine first uses side-effect-free defaults; the required ordering is documented.

### Theme reload behavior

- [x] Verify reloads restore defaults after terminal, transparency, style, callback, and integration overrides.
- [x] Verify disabling a previously enabled integration clears its groups after reload.
- [x] Verify transparent and opaque reloads correctly replace one another.
- [x] Run `highlight clear` unconditionally during theme setup and cover reload behavior in tests.

## 3. Documentation

### Installation and requirements

- [x] Split plain `lazy.nvim` installation from LazyVim installation.
- [x] Keep LazyVim guidance about owning the final colorscheme load.
- [ ] Verify every installation snippet in a clean configuration.
- [ ] State the minimum Neovim version and true-color requirement.
- [ ] Resolve all repository-owner references.

### Integration table

- [x] Turn every plugin name into a link to its upstream repository.
- [x] Limit documented highlight surfaces to those currently implemented.
- [x] Remove the unsupported gitsigns inline-blame claim.
- [x] Remove the unsupported render-markdown checkbox and callout claims.
- [x] Verify integration highlight names against current upstream plugin source; remove or rename stale cmp, which-key, and Snacks groups.
- [ ] Note any integration requiring a minimum plugin version.

### Configuration and overrides

- [x] Replace the `bg_float = "#151b1e"` override example because it currently assigns the default value.
- [x] Document all supported public semantic color override keys.
- [x] Explain how style options are deep-merged.
- [x] Show that disabling a default style requires `italic = false` or `bold = false`.
- [x] Document `plugins.auto`, `plugins.all`, manual booleans, and precedence clearly.
- [x] Document the `on_colors` and `on_highlights` callback lifecycle.
- [x] Clarify that `colors.roles` is internal.

### Palette documentation

- [x] Document every authored palette color, not only a subset.
- [x] Keep the named palette and `palette.base16` mapping examples current.
- [x] Add a palette swatch with names and hex values.
- [ ] Decide whether British `grey` spelling is part of the permanent public interface.

### Vim help

- [ ] Decide whether `:help vulkanite` is required for v0.1.0.
- [ ] If required, add `doc/vulkanite.txt` covering installation, setup, styles, integrations, overrides, and palette access.
- [ ] Generate helptags and verify the help file opens without errors.

## 4. Visual QA

### Syntax identity

Verify each language with Tree-sitter alone and with LSP semantic tokens enabled.

- [ ] Variables, parameters, and literals remain recognizably coral red.
- [ ] Properties and members are bright teal.
- [ ] Constants and enum members are bold purple.
- [ ] Imported functions and types preserve their semantic function/type styling.
- [ ] Import keywords are visually distinct from imported symbols.
- [ ] Functions and methods are upright bright blue.
- [ ] Classes, structs, interfaces, enums, aliases, and built-in types are italic sky blue.
- [ ] Keywords and control flow are consistently bold dark teal.
- [ ] Operators and punctuation remain readable light grey.
- [ ] Strings are upright green and documentation strings use authored yellow.
- [ ] Comments and documentation comments are italic grey.
- [ ] Escapes, regular expressions, decorators, and special syntax use muted blue consistently.
- [ ] Errors remain distinguishable from coral variables and literals.
- [ ] Readonly, default-library, and built-in modifiers do not add unexpected italics.

### Language matrix

- [ ] Rust: structs, enums, traits, macros, lifetimes, attributes, and mutable bindings.
- [ ] Go: structs, interfaces, methods, package names, imports, and constants.
- [ ] TypeScript/JavaScript: imports, classes, interfaces, generics, decorators, properties, and JSX/TSX.
- [ ] Python: imports, decorators, classes, methods, parameters, and type annotations.
- [ ] Lua: modules, tables, functions, fields, built-ins, and strings.
- [ ] Markdown: headings, emphasis, links, code blocks, lists, tables, and quotes.

### Editor and plugin UI

- [ ] Visual selection, popup selection, quickfix selection, and wildmenu remain readable.
- [ ] Cursor line and cursor line number are visible without dominating syntax.
- [ ] Float borders and split separators remain subdued.
- [ ] Search, incremental search, and matching delimiters are clear.
- [ ] Diagnostics, virtual text, signs, and undercurls are distinguishable by severity.
- [ ] Diff add/change/delete/text groups are readable.
- [ ] Lualine modes are distinct: normal, insert, command, visual, replace, and terminal.
- [ ] Completion menus remain readable in both nvim-cmp and blink.cmp.
- [ ] Telescope and Snacks picker selections and matches are clear.
- [ ] Neo-tree and nvim-tree states are distinguishable.
- [ ] Notifications and Noice severity mappings are consistent.
- [ ] Render Markdown groups match documented support.

### Accessibility and terminals

- [ ] Inspect the theme with protanopia, deuteranopia, and tritanopia simulation.
- [ ] Pay particular attention to coral variables versus green strings.
- [ ] Verify the theme in at least two terminals or GUIs.
- [ ] Verify italics and bold styles with a font that supports both correctly.
- [x] Add automated contrast floors for normal text, comments, selections, keywords, and diagnostics.
- [ ] Confirm the theme remains usable when terminal italics are disabled.

## 5. Testing and automation

### Continuous integration

- [x] Add a GitHub Actions workflow.
- [x] Configure the headless test suite in CI.
- [x] Configure the direct colorscheme smoke test in CI.
- [x] Configure StyLua 2.5.2 in check mode in CI.
- [x] Configure `git diff --check` in CI.
- [x] Deliberately track Neovim stable and nightly; nightly is non-blocking.
- [ ] Confirm the workflow passes after it is pushed to GitHub.
- [ ] Add a status badge to the README after CI is stable.

### Regression coverage

- [x] Test all documented setup defaults.
- [x] Test style enable and disable overrides.
- [x] Test every integration's representative highlight group.
- [x] Test lazy.nvim auto-detection.
- [x] Test `vim.pack` auto-detection on a supporting Neovim version.
- [x] Test manual integration values overriding auto-detection.
- [x] Test palette uniqueness and Base16 completeness.
- [x] Test public color and highlight callbacks.
- [x] Test terminal, transparency, and integration reloads across option changes.
- [x] Test the legacy `vulkan-colors` colorscheme alias.

## 6. Release preparation

### Repository cleanup

- [x] Review the current diff for stale comments, dead role fields, misleading claims, and outdated integration groups.
- [ ] Ensure every commit intended for `main` passes tests.
- [ ] Avoid publishing the intermediate failing snapshot as part of the main branch history.
- [ ] Decide whether to squash-merge or rebase the feature branch.
- [ ] Confirm `git status` is clean before tagging.

### Release metadata

- [ ] Choose the first release version, provisionally `v0.1.0`.
- [x] Draft release notes at `docs/release-notes-v0.1.0.md` describing the visual identity, integrations, and override interface.
- [ ] Finalize release notes after owner, license, minimum Neovim version, screenshots, and compatibility decisions are resolved.
- [ ] Add a changelog if releases will be tracked in-repository.
- [ ] Add GitHub repository description, topics, and screenshots.
- [ ] Confirm the default branch contains the release commit.
- [ ] Create and push the annotated tag.
- [ ] Create the GitHub release from that tag.

### Final verification

Run from a clean checkout:

```sh
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
nvim --headless -u NONE \
  -c 'set rtp^=.' \
  -c 'colorscheme vulkanite' \
  -c 'lua assert(vim.g.colors_name == "vulkanite")' \
  -c 'qa'
stylua colors lua test demo/showcase.lua --check
git diff --check
git status --short
```

Expected results:

- Every command exits successfully.
- The final `git status --short` output is empty.
- CI passes on every required Neovim version.
- Installation snippets work from clean configurations.
- Screenshots match the released palette and mappings.

## Open decisions

- [ ] Canonical GitHub owner: `squidmilk` or `kyerpotts`.
- [ ] License.
- [ ] Minimum supported Neovim version.
- [ ] Whether nightly Neovim failures block a release.
- [ ] Whether `:help vulkanite` is required for v0.1.0.
- [ ] Whether the legacy `vulkan-colors` alias remains supported.
- [ ] Whether British `grey` spelling is final in the public palette interface.
- [ ] Whether the feature branch should be squash-merged or rebased.
