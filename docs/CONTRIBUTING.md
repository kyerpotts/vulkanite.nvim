# Contributing to Vulkanite

Thanks for taking the time to contribute. Vulkanite has a deliberate visual
identity, so the best changes extend that identity rather than redesign it.

## What we need most

Integration contributions are the highest priority. Good candidates include:

- Adding support for a plugin that does not have Vulkanite highlights yet.
- Updating highlight groups after an upstream plugin changes its interface.
- Fixing an integration that does not follow Vulkanite's existing semantic
  colors and typography.
- Adding focused regression coverage for supported integrations.

Before adding or changing an integration:

1. Verify the highlight groups against the plugin's current upstream source.
2. Reuse Vulkanite's semantic color roles instead of selecting raw palette
   colors inside the integration.
3. Add a representative test that would fail if the integration regressed.
4. Update the help documentation when the supported surface changes.

## Baseline colorscheme changes

Changes to the baseline palette, syntax identity, or editor highlights are
considered only when one of these conditions applies:

- There is substantial demand for the change in the issue tracker.
- The current behavior breaks Vulkanite's visual identity.

A visual identity issue is an inconsistency rather than a preference. For
example, if types are intentionally sky blue but an LSP semantic highlight
renders struct declarations in an unrelated color, that is a useful issue to
fix. A request to replace sky blue with a different color everywhere is a
redesign and needs strong community demand first.

Open an issue before starting a broad visual change. Include screenshots,
language and plugin details, active LSP clients, and the relevant highlight
groups where possible.

## AI-assisted contributions

AI-assisted changes are welcome, but generated output is not accepted on trust.
Before submitting a change, you must:

- Read and understand the code you are submitting.
- Remove generated cruft, speculative abstractions, and unrelated edits.
- Check that the change follows the surrounding project conventions.
- Run the relevant tests and manually inspect visual changes.
- Be able to explain and maintain the result.

The contributor remains responsible for the quality and correctness of the
change, regardless of which tools helped produce it.

## Development setup

Vulkanite supports Neovim 0.10 and later. Clone the repository and run the
headless suite from its root:

```sh
nvim --headless -u test/minimal_init.lua -S test/vulkanite_spec.lua +qa
```

Run the direct colorscheme smoke test:

```sh
nvim --headless -u NONE \
  -c 'set rtp^=.' \
  -c 'colorscheme vulkanite' \
  -c 'lua assert(vim.g.colors_name == "vulkanite")' \
  -c 'qa'
```

Check formatting and whitespace:

```sh
stylua colors lua test demo/showcase.lua --check
git diff --check
```

The scripts under [`scripts/`](../scripts/) create disposable Neovim
configurations for manually checking the documented installation methods.

## Commits and pull requests

Vulkanite uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
for commit messages and pull-request titles. Examples:

```text
feat: add support for a plugin
fix(treesitter): keep struct declarations consistent with types
docs: clarify integration configuration
```

Keep pull requests focused. Explain what changed, how it was verified, and any
upstream plugin versions or highlight groups involved. Include before-and-after
screenshots for visual changes.

Pull requests must pass the required CI checks and be up to date with `main`.
Accepted pull requests are squash-merged, so the pull-request title becomes the
commit subject on `main`.
