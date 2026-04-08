# dotfiles

Personal Nix-based environment setup for Linux and macOS, managed with
[Home Manager](https://github.com/nix-community/home-manager) on Linux and
[nix-darwin](https://github.com/LnL7/nix-darwin) + Home Manager on macOS.

## Bootstrap

No dependencies beyond `curl` and `sh` — Nix is fetched by the installer,
and the dotfiles are fetched directly from GitHub by Nix (no `git` required).

Run the setup script directly:

```sh
curl -fsSL https://raw.githubusercontent.com/f-squirrel/dotfiles/main/setup.sh | sh -s full
```

Or, if you already have the repo cloned:

```sh
sh setup.sh full
```

On Linux, this installs Nix in daemon (multi-user) mode, enables flakes,
applies the Home Manager configuration, and sets up GPU drivers on
non-NixOS Linux — all in one step. Conflicting files are backed up with
a `.backup` suffix.

On macOS, the script uses nix-darwin instead of Home Manager directly.
GUI apps (`brave`, `dropbox`, `keepassxc`, `telegram`) are managed via
Homebrew casks in the `full` profile.

Git identity defaults to the repo owner's values but can be overridden via
environment variables:

```sh
GIT_NAME="Alice Smith" GIT_EMAIL="alice@example.com" sh setup.sh
```

The username is taken from the `$USER` environment variable automatically.

## Structure

```text
flake.nix                        # Flake inputs, homeConfigurations and darwinConfigurations outputs
setup.sh                         # Bootstrap script (installs Nix + applies config)
modules/
  shared/                        # Cross-platform Home Manager modules
    alacritty.nix                # Alacritty terminal emulator
    atuin.nix                    # Shell history with Atuin
    base.nix                     # Base configuration shared across profiles
    btop.nix                     # System monitor
    dropbox.nix                  # Dropbox (Linux only; macOS via Homebrew)
    eza.nix                      # Modern ls replacement
    fonts.nix                    # Nerd fonts + fontconfig defaults
    fzf.nix                      # Fuzzy finder
    git.nix                      # Git configuration
    neovim.nix                   # Neovim editor
    packages-cli.nix             # Common CLI packages
    packages-cpp.nix             # C++ development packages
    packages-darwin.nix          # macOS-specific CLI packages
    packages-gui.nix             # GUI packages (Linux only; macOS via Homebrew)
    packages-python.nix          # Python packages
    ripgrep.nix                  # Fast grep replacement
    rust.nix                     # Rust toolchain
    starship.nix                 # Shell prompt
    zellij.nix                   # Terminal multiplexer
    zoxide.nix                   # Smarter cd
    zsh.nix                      # Zsh shell configuration
  darwin/                        # macOS-specific nix-darwin modules
    base.nix                     # nix-darwin base: home-manager integration, nixpkgs config
    homebrew.nix                 # Homebrew casks for GUI apps (full profile only)
profiles/
  linux/                         # Home Manager profiles for Linux (standalone)
    dev.nix                      # Dev profile (minimal + Rust/Python/C++ toolchains, claude-code, devcontainer)
    full.nix                     # Full profile (dev + GUI apps)
    minimal.nix                  # Minimal profile
  darwin/                        # nix-darwin profiles for macOS
    dev.nix                      # Darwin dev profile
    full.nix                     # Darwin full profile (+ Homebrew casks)
    minimal.nix                  # Darwin minimal profile
config/
  alacritty/                     # Alacritty config
  nvim/                          # Neovim config
  zellij/                        # Zellij config and layouts
scripts/
  open-ide.sh                    # Opens project in VS Code (with devcontainer support) or nvim
  worktree.sh                    # Git worktree helpers: wt, wtl, wtr
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

| Target                     | Description                                                                  |
| -------------------------- | ---------------------------------------------------------------------------- |
| `just apply <profile>`     | Apply configuration (`full`, `dev`, or `minimal`); uses nix-darwin on macOS  |
| `just nix-update`          | Update all flake inputs                                                      |
| `just nix-check`           | Validate flake structure                                                     |
| `just nix-build <profile>` | Build configuration without applying (`full`, `dev`, or `minimal`)           |
| `just nix-shell`           | Open a shell with the built home-path                                        |
| `just gpu-setup`           | Set up GPU drivers (non-NixOS Linux, run after apply)                        |
| `just news <profile>`      | Show Home Manager news (`full`, `dev`, or `minimal`)                         |
| `just docker-test`         | Build and run a Docker container to test config from scratch                 |
| `just init`                | Symlink linter configs from the submodule into the repo root                 |
| `just lint`                | Run all linters                                                              |
| `just commit-lint`         | Validate commits against Conventional Commits specification                  |
| `just md-lint`             | Lint Markdown files (pass `fix` to auto-fix)                                 |
| `just yaml-lint`           | Lint YAML files                                                              |
| `just just-fmt`            | Check justfile formatting (pass `fix` to auto-format)                        |

All linters run inside Docker — no local installation required beyond
Docker and just.

### Commit conventions

Commits must follow the
[Conventional Commits](https://www.conventionalcommits.org) specification.
Config is in `.commitlintrc.yml`.
