# Repository Guidelines

## Project Structure & Module Organization
This repository is an AstroNvim-based Neovim config. `init.lua` bootstraps `lazy.nvim` and loads `lua/lazy_setup.lua`, which imports AstroNvim core, community plugins, and local plugin specs. Keep reusable plugin configuration in `lua/plugins/*.lua`; use one file per concern such as LSP, Treesitter, UI, or Mason. `lua/community.lua` controls imported community packs, and `lua/polish.lua` is the last-stop file for small runtime tweaks that do not fit elsewhere. Dependency versions are pinned in `lazy-lock.json`.

Several files still contain AstroNvim template guards such as `if true then return {} end`. Remove those lines only when you intend to activate and maintain that module.

## Build, Test, and Development Commands
- `nvim`: start the config locally and let `lazy.nvim` bootstrap missing plugins.
- `nvim --headless "+Lazy! sync" +qa`: install or update plugins and refresh `lazy-lock.json`.
- `stylua .`: format Lua files using `.stylua.toml`.
- `selene .`: lint Lua code against `selene.toml`.
- `nvim --headless "+checkhealth" +qa`: run Neovim health checks after plugin, LSP, or tool changes.

## Coding Style & Naming Conventions
Use Lua with 2-space indentation, 120-column lines, and double-quote preference as enforced by StyLua. Match AstroNvim conventions: plugin spec files return `LazySpec` tables, option blocks stay declarative, and ad hoc logic belongs in small local functions. Name plugin files by feature area, for example `lua/plugins/treesitter.lua` or `lua/plugins/none-ls.lua`.

## Testing Guidelines
There is no committed automated test suite in this checkout. For every change, run `stylua .`, `selene .`, and at least one headless Neovim check. When touching plugin loading, keymaps, or LSP setup, also run `nvim --headless "+Lazy! sync" +qa` and `nvim --headless "+checkhealth" +qa`.

## Commit & Pull Request Guidelines
Local Git history is not available in this workspace, so use short imperative commits with a clear scope, for example `feat(plugins): add markdown preview` or `fix(lsp): disable lua_ls formatting`. Keep PRs focused, explain the user-visible change, list validation commands you ran, and include screenshots or short recordings for UI-facing updates such as dashboards, colors, or statusline changes. If plugin versions move, include the resulting `lazy-lock.json` update in the same PR.
