# AGENTS.md

Guidance for agents (and humans) contributing to this repository.

## Docs rules

- Keep `README.md` and `README_zh.md` in sync: any table row, section or example added to one
  must be added to the other, translated.
- **Packages table is sorted alphabetically by package name** (case-insensitive, plain ASCII
  order), in both READMEs. When you add a package, insert it in the correct position instead of
  appending it to the end.
- Package table rows link the package name to its upstream home page, and the version column
  lists versions newest-first.

## Adding a package

1. Create `packages/<first-letter>/<name>/xmake.lua` with `set_homepage`, `set_description`,
   `set_license`, `add_urls`, `add_versions` (with sha256) and `on_install`.
2. Add the package to the table in `README.md` and `README_zh.md`, alphabetically.
3. Commit as `feature: add <name> <version>`.
