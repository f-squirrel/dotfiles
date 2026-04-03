# dotfiles

Personal Nix-based environment setup for Linux and macOS.

## Bootstrap

Install Nix (daemon/multi-user mode):

```sh
sh setup.sh
```

## Repository tooling

Tooling is provided via [just](https://just.systems) and managed through
the [repo-setup](https://github.com/f-squirrel/repo-setup) submodule.

### First-time setup

Symlink linter config files into the repo root:

```sh
just init
```

### Available targets

| Target             | Description                                                  |
|--------------------|--------------------------------------------------------------|
| `just init`        | Symlink linter configs from the submodule into the repo root |
| `just lint`        | Run all linters                                              |
| `just commit-lint` | Validate commits against Conventional Commits specification  |
| `just md-lint`     | Lint Markdown files (pass `fix` to auto-fix)                 |
| `just yaml-lint`   | Lint YAML files                                              |
| `just just-fmt`    | Check justfile formatting (pass `fix` to auto-format)        |

All linters run inside Docker — no local installation required beyond
Docker and just.

### Commit conventions

Commits must follow the
[Conventional Commits](https://www.conventionalcommits.org) specification.
Config is in `commitlint.config.js`.
