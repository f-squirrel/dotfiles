# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.
See [README.md](README.md) for a full overview of the structure and tooling.

## Repository structure

This is a Nix-based dotfiles repo supporting Linux (Home Manager standalone)
and macOS (nix-darwin + Home Manager). Key directories:

- `modules/shared/` — cross-platform Home Manager modules (no OS conditionals)
- `modules/linux/` — Linux-only Home Manager modules (no `isLinux` guards needed)
- `modules/darwin/` — macOS-only nix-darwin modules (no `isDarwin` guards needed)
- `profiles/shared/` — cross-platform HM profile definitions (`minimal`, `dev`)
- `profiles/linux/` — Linux profile wrappers (import shared + linux-specific modules)
- `profiles/darwin/` — nix-darwin profiles (import darwin modules + shared HM profiles)

## Key conventions

- **No OS conditionals in modules.** If a module is Linux-only, it lives in
  `modules/linux/` and is imported only from `profiles/linux/`. Same for darwin.
  Never use `pkgs.stdenv.isLinux` / `isDarwin` guards.
- **Fonts:** Linux installs via `home.packages` + fontconfig in `modules/linux/fonts.nix`.
  macOS installs system-wide via nix-darwin `fonts.packages` in `modules/darwin/fonts.nix`.
- **GUI apps on macOS** are managed via Homebrew casks in `modules/darwin/homebrew.nix`,
  not via `home.packages`.
- **darwin/base.nix** wires up home-manager inside nix-darwin (`useGlobalPkgs`,
  `useUserPackages`, `sharedModules`, `users.users.${username}.home`, etc.).
  Darwin HM profiles import from `profiles/shared/` — never from `profiles/linux/`.

## Workflow

```sh
just lint          # run all linters (inside Docker)
just nix-check     # validate flake evaluation
just nix-build <profile>   # build without applying
just apply <profile>       # apply config (OS-aware)
```

After editing Nix files, always run `just nix-check` before committing.
Commits must follow [Conventional Commits](https://www.conventionalcommits.org)
— validated by `just commit-lint` (runs automatically as a pre-commit hook).
