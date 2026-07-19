# Vulkanite release preview

Vulkanite uses coral variables and parameters, bright-foreground properties, *italic functions*, bold upright types, bold-italic constructors, upright strings, yellow documentation strings, and bold purple constants.

> The interface should recede so that syntax remains the primary visual identity.

## Release checks

- [x] Distinct authored palette colors
- [x] Tree-sitter and LSP semantic mappings
- [ ] Screenshots from a clean configuration
- [ ] Cross-terminal visual verification

| Role | Presentation | Example |
| --- | --- | --- |
| Function | Bright blue, italic | `render_preview()` |
| Type | Sky blue, bold upright | `PaletteEntry` |
| Constructor | Sky blue, bold italic | `PaletteEntry(...)` |
| Parameter | Coral red, upright | `theme` |
| Property | Bright foreground, upright | `theme.name` |
| Constant | Purple, bold | `DEFAULT_TIMEOUT` |
| Value | Coral red | `timeout = 250` |
| String | Green, upright | `"vulkanite"` |
| Documentation | Yellow, upright | `\"\"\"Build a palette.\"\"\"` |

```rust
pub fn render(theme: &Theme) -> Result<String, RenderError> {
    theme.validate()?;
    Ok(format!("theme: {}", theme.name))
}
```

See the [Neovim documentation](https://neovim.io/doc/) for runtime-path details.
