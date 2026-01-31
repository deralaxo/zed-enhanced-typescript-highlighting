# Enhanced TypeScript Highlighting for Zed

This extension provides enhanced syntax highlighting for TypeScript, TSX, and JavaScript with granular token captures that allow themes to style different syntax elements independently.

## Recommended Theme

This extension was created specifically for this theme [Community Material Ocean Theme](https://github.com/deralaxo/community-material-ocean-theme-zed)

## Features

### Granular Keyword Captures
- `@keyword.coroutine` - `await` (can be styled differently from other keywords)
- `@keyword.modifier` - `async`, `static`, `private`, `public`, `protected`, `readonly`, `abstract`, `override`
- `@keyword.operator` - `delete`, `in`, `instanceof`, `new`, `of`, `typeof`, etc.
- `@keyword.control` - `if`, `else`, `for`, `while`, `return`, `break`, `as`, etc.
- `@keyword.module` - `declare`, `module`, `namespace`
- `@keyword.accessor` - `get`, `set`
- `@keyword.declaration` - `const`, `let`, `var`, `function`, `class`, `interface`, `type`, `enum`
- `@keyword.import` - `import`, `export`, `from`

### Enhanced Type Captures
- `@type.super` - Extended types in `extends` clauses
- `@type.class` - Class names in declarations

### Constant Highlighting
- Variables declared with `const` are captured as `@constant`
- Destructured const variables (including rest patterns) are captured as `@constant`
- UPPER_CASE identifiers are captured as `@constant`
- UPPER_CASE member properties (like `process.env.GITHUB_TOKEN`) are captured as `@constant`

### Punctuation Captures
- `@punctuation.interpolation` - Template string `${}`
- `@punctuation.special` - Type annotations `:`, union `|`, intersection `&`, decorators `@`

### Usage

The extension provides three languages:
- **TypeScript Enhanced** - for `.ts`, `.cts`, `.mts` files
- **TSX Enhanced** - for `.tsx` files  
- **JavaScript Enhanced** - for `.js`, `.jsx`, `.mjs`, `.cjs` files

These will automatically be used for the corresponding file extensions. If you want to use the built-in languages instead, you can configure `file_types` in your Zed settings.

## Theme Compatibility

This extension uses hierarchical captures that fall back gracefully:
- `@keyword.coroutine` falls back to `@keyword` if not defined
- `@keyword.modifier` falls back to `@keyword` if not defined
- etc.

So themes that don't define these granular styles will still work correctly.
