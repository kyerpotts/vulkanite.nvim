# Screenshot fixtures

Open these files with Tree-sitter and an LSP client enabled to capture release screenshots. Use the same terminal, font, window size, and Neovim configuration for every image.

Recommended primary capture:

```sh
nvim demo/showcase.rs
```

Recommended secondary captures:

- `showcase.go`: structs, interfaces, methods, packages, constants, and errors.
- `showcase.tsx`: imports, generics, classes, JSX, and async functions.
- `showcase.py`: imports, decorators, classes, annotations, and comprehensions.
- `showcase.lua`: modules, tables, functions, methods, and comments.
- `showcase.md`: headings, emphasis, links, lists, quotes, tables, and code.

Before capturing:

1. Load `vulkanite` with `plugins = { all = true }`.
2. Wait for Tree-sitter parsing and LSP semantic tokens.
3. Hide personal paths and machine-specific statusline content.
4. Capture one clean editor view and one view containing completion, diagnostics, or a picker.
5. Record the terminal or GUI, font, Neovim version, and visible plugins for the README caption.
