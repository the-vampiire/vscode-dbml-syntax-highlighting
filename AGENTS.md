# AGENTS.md

## Commands
- Build: npm run compile
- Lint: npm run lint
- Test: npm run test
- Run single test: npm run test -- --grep "test name"
- Package extension: vsce package
- Install locally: code --install-extension your-extension.vsix
- Run in dev host: F5 in VS Code

## Code Style
- Language: TypeScript for extension code.
- Imports: Use ES6 imports; group by external, then internal.
- Formatting: Follow Prettier config if present; 2-space indent.
- Types: Use TypeScript strict mode; prefer interfaces for objects.
- Naming: camelCase for variables/functions; PascalCase for classes/types.
- Error handling: Wrap async ops in try-catch; log errors appropriately.
- Grammar: Use .dbml suffix for TextMate scopes; case-sensitive keywords.
- Conventions: Follow VS Code extension best practices; no console.logs in prod.