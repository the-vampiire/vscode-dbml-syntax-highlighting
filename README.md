# DBML Syntax Highlighting

This extension provides syntax highlighting for DBML files in Visual Studio Code.

## Prerequisites

- Node.js (version 16 or higher)
- VS Code Extension Manager (`vsce`): Install globally with `npm install -g vsce`

## Development Setup

1. Install dependencies: `npm install`
2. Compile the extension: `npm run compile` (though no compilation is needed for this grammar-only extension)
3. Run in Extension Development Host: Press F5 in VS Code with this project open.
4. Open or create a `.dbml` file (e.g., `sample-dbml/test.dbml`) and verify syntax highlighting:
   - Keywords (e.g., Table, Enum) in blue bold
   - Types (e.g., int, varchar) in green bold
   - Strings in red
   - Comments in green italic
   - Numbers in teal
   - Operators and punctuation in black

## Testing

1. Run in Extension Development Host: Press F5 in VS Code with this project open.
2. Create or open a `.dbml` file and verify highlighting for keywords, types, strings, comments, numbers, operators, and punctuation.
3. Expected: Keywords like 'Table' in blue bold, types like 'int' in green bold, strings in red, comments in green italic, numbers in teal, operators in black.

## Packaging and Installation

1. Package the extension: `npm run package` (generates `.vsix` file)
2. Install locally: `code --install-extension dbml-syntax-highlighting-0.0.1.vsix`
3. Reload VS Code if needed.

## Publishing (Optional)

- Publish to marketplace: `npm run publish` (requires authentication with `vsce login`)

## Usage

Open any `.dbml` file in VS Code. The extension automatically applies syntax highlighting based on the TextMate grammar.

## Documentation Links

- [VS Code TextMate grammar contribution](https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide)
- [TextMate grammars / scope naming conventions](https://macromates.com/manual/en/language_grammars) and [Sublime Text scope naming](https://www.sublimetext.com/docs/3/scope_naming.html)
- [VS Code theming and tokenColorCustomizations](https://code.visualstudio.com/api/extension-guides/color-theme)
- [Monarch tokenizer docs](https://microsoft.github.io/monaco-editor/monarch.html)
- [VS Code extension packaging/publishing](https://code.visualstudio.com/api/working-with-extensions/publishing-extension)