# dotfiles

Personal Nix-based environment setup for Linux and macOS,
managed with [Home Manager](https://github.com/nix-community/home-manager).

## Bootstrap

No dependencies beyond `curl` and `sh` — Nix is fetched by the installer,
and the dotfiles are fetched directly from GitHub by Nix (no `git` required).

Run the setup script directly:

```sh
curl -fsSL https://raw.githubusercontent.com/f-squirrel/dotfiles/main/setup.sh | sh
```

Or, if you already have the repo cloned:

```sh
sh setup.sh
```

This installs Nix in daemon (multi-user) mode, enables flakes, applies
the Home Manager configuration, and sets up GPU drivers on non-NixOS Linux —
all in one step. Conflicting files are backed up with a `.backup` suffix.

## Structure

```text
flake.nix                        # Flake inputs and homeConfigurations outputs
setup.sh                         # Bootstrap script (installs Nix + applies config)
home/
  default.nix                    # Top-level Home Manager config
  modules/
    alacritty.nix                # Alacritty terminal emulator
    atuin.nix                    # Shell history with Atuin
    btop.nix                     # System monitor
    eza.nix                      # Modern ls replacement
    fzf.nix                      # Fuzzy finder
    git.nix                      # Git configuration
    neovim.nix                   # Neovim editor
    packages.nix                 # Common CLI packages
    packages-darwin.nix          # macOS-specific packages
    ripgrep.nix                  # Fast grep replacement
    rust.nix                     # Rust toolchain
    starship.nix                 # Shell prompt
    zellij.nix                   # Terminal multiplexer
    zellij/                      # Zellij config and layouts
    zoxide.nix                   # Smarter cd
    zsh.nix                      # Zsh shell configuration
scripts/
  utils/
    vscode-open.sh               # Helper for opening files in VS Code
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
| `just apply`       | Apply Home Manager configuration for the current system      |
| `just nix-update`  | Update all flake inputs                                      |
| `just nix-check`   | Validate flake structure                                     |
| `just nix-build`   | Build configuration without applying                         |
| `just nix-shell`   | Open a shell with the built home-path                        |
| `just gpu-setup`   | Set up GPU drivers (non-NixOS Linux, run after apply)        |
| `just news`        | Show Home Manager news for the current system                |
| `just docker-test` | Build and run a Docker container to test config from scratch |
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
Config is in `.commitlintrc.yml`.
