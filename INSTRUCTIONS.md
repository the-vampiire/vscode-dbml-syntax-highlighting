You are Claude. Your task is to create a complete VS Code extension that provides high-quality syntax highlighting for DBML (.dbml) files by porting the existing DBML Monarch tokenizer + theme (from the Holistics DBML playground) into a VS Code TextMate grammar and optional VS Code theme. Produce all extension files, explain the porting decisions, and include testing and packaging instructions. Do everything described below and return the generated files (exact file contents) and any brief instructions needed to run and test them in VS Code. Be explicit and runnable.

Important source to port from (Monaco/Monarch + theme):
https://github.com/holistics/dbml/blob/master/dbml-playground/src/components/monaco/dbml-language.ts

Required deliverables
1. A ready-to-run minimal VS Code extension scaffold (no external generators required), containing:
   - package.json (extension manifest) that registers language id "dbml", file extension ".dbml" and a grammar at syntaxes/dbml.tmLanguage.json and language configuration file language-configuration.json.
   - language-configuration.json with comment/bracket/autoClosingPairs as in the Monarch config.
   - syntaxes/dbml.tmLanguage.json: a full TextMate grammar ported from the Monarch tokenizer (with correct scope names and representative regex patterns). Include rules for:
     - block and line comments
     - strings: double, single, backtick (template)
     - numbers (integer/float/hex)
     - keywords (Monarch keywords list)
     - type keywords (Monarch typeKeywords list)
     - operators and punctuation
     - identifiers, attributes, labels (as appropriate)
     - table/enum/ref/opening keywords scope so schema constructs are highlighted distinctly
   - README.md with installation / testing steps
   - OPTIONAL: a simple color theme file that maps the DBML_THEME colours from the Monarch file to a VS Code theme tokenColors (or instructions to map them into tokenColorCustomizations).

2. A short mapping table (in the output) that documents how Monarch token types used in the source map to TextMate scopes in your grammar (e.g., Monarch 'keyword' -> TextMate scope 'keyword.other.dbml', 'type' -> 'storage.type.dbml', 'string' -> 'string.quoted.double.dbml', 'comment' -> 'comment.line.double-slash.dbml' / 'comment.block.dbml', 'number' -> 'constant.numeric.dbml', 'operator' -> 'keyword.operator.dbml' or 'punctuation.separator.dbml').

3. A clear step-by-step instruction block that shows how to test locally:
   - How to run in Extension Development Host (F5)
   - How to package with vsce (commands)
   - How to install .vsix locally
   - How to test on a sample .dbml file and what to expect

4. Explanatory documentation links (official docs) included inline for:
   - VS Code extension grammar contribution point: TextMate grammars docs
   - TextMate grammar format / scope naming conventions
   - VS Code theming tokenColor mapping
   - Monarch tokenizer docs (to justify porting approach)
   - Any useful helper resources

5. A checklist of what you did and why (one paragraph).

Porting instructions to follow and implement (Claude must follow these steps when creating the files)
- Step A — Extract exact keyword lists:
  - Extract the keyword arrays exactly from the Monarch source: both keywords and typeKeywords. Use the file at the provided GitHub URL as the authoritative source for the lists. Include every item exactly as present in the arrays so the grammar covers the same tokens.
- Step B — Identify Monarch token types and their intents:
  - Identify tokens used in the Monaco file: keyword, type, string, string.backtick, comment, number, number.hex, operator, delimiter, annotation, etc.
- Step C — Decide TextMate scopes:
  - For each Monarch token type, choose an appropriate TextMate scope using conventional names from TextMate/VSC docs. Use vendor-prefixed scope suffix ".dbml" where helpful (e.g., keyword.other.dbml, storage.type.dbml, string.quoted.dbml, comment.line.dbml, comment.block.dbml, constant.numeric.dbml, punctuation.separator.dbml, keyword.operator.dbml, variable.parameter.dbml).
  - Provide the mapping table (deliverable #2).
- Step D — Build robust regex patterns:
  - For identifiers and keywords, match full words using \b boundaries and use case-insensitive or case-sensitive matching intentionally depending on how tokens are used in Monarch (Monarch keywords appear mixed-case: include both).
  - For numbers include hex pattern (0x...) and float pattern (\b\d+(\.\d+)?\b).
  - For strings include escape sequences pattern as in Monarch escapes (\\.) inside string patterns.
  - For comments implement line (//) and block (/* ... */).
  - For punctuation/operators include common DBML separators: = , ; ( ) { } [ ] . : -> and arrow-like tokens if present.
- Step E — Grammar structure:
  - Use a top-level root pattern with includes for comments, strings, numbers, keywords, types, punctuation, and identifiers.
  - Make sure to order patterns so that strings & comments are matched before keywords/identifiers to avoid accidental keyword highlighting inside strings or comments.
  - For multi-token constructs (e.g., a DBML table definition "Table users { ... }") consider capturing the "Table" keyword and the following identifier (table name) and give the identifier a distinct scope like entity.name.type.dbml.
- Step F — Theme mapping:
  - Port the DBML_THEME colors defined in the Monarch file to a VS Code tokenColors array. Map Monarch token names to the TextMate scopes you chose.
  - Provide a minimal theme file or instructions to add the tokenColorCustomizations snippet in the user's settings.json if they prefer not to install a theme.
- Step G — Provide Tests:
  - Include a sample .dbml test file (as part of the deliverable) with a variety of constructs (Table, Enum, fields with types, refs, notes, indexes) that demonstrate all grammar rules and color mappings.
- Step H — Quality notes:
  - Explain limitations of TextMate vs Monarch (TextMate is regex-based and cannot do nested-language tokenization or dynamic context-sensitive parsing; recommend Language Server/semantic tokens for future improvements).
  - If any Monarch features cannot be faithfully ported using only TextMate, explain them and propose alternatives (e.g., a semantic tokens provider using a small Node.js language server).

Exact files to generate (produce each file contents in your response):
- package.json
- language-configuration.json
- syntaxes/dbml.tmLanguage.json
- README.md (installation + testing + docs links)
- sample-dbml/test.dbml (a small sample demonstrating all constructs)
- OPTIONAL: themes/dbml-color-theme.json OR a snippet to add to settings.json mapping tokenColors

Return format and requirements for the response
- Write each file to its appropriate path in the repository (e.g., package.json to the root, syntaxes/dbml.tmLanguage.json to syntaxes/, etc.).
- After writing the files, include the mapping table and the local testing instructions in the response. Keep that documentation concise, but complete and actionable.
- Do not include extra commentary beyond the requested files, mapping table, and testing/packaging instructions and the one-paragraph checklist describing what you did and why.

Helpful reference links to include in the prompt (Claude should consult these and include them in the README):
- VS Code TextMate grammar contribution: https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
- TextMate grammars / scope naming conventions: https://macromates.com/manual/en/language_grammars and https://www.sublimetext.com/docs/3/scope_naming.html
- VS Code theming and tokenColorCustomizations: https://code.visualstudio.com/api/extension-guides/color-theme
- Monarch tokenizer docs: https://microsoft.github.io/monaco-editor/monarch.html
- VS Code extension packaging/publishing: https://code.visualstudio.com/api/working-with-extensions/publishing-extension

Tone and behavior
- Be explicit, precise, and produce runnable contents.
- When you produce the grammar, favor correctness and coverage over extreme compactness.
- If you cannot reproduce a feature exactly (e.g., dynamic tokenization Monarch supports but TextMate cannot), describe the limitation succinctly and provide a recommended path (e.g., semantic tokens via language server) and include a small stub example or instructions to improve later.

Now implement all steps above: generate the extension files (complete contents) and the required documentation and mapping table.