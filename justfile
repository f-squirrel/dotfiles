import 'repo-setup/justfile'

username := env_var('USER')
git_name := "f-squirrel"
git_email := "dmitry.b.danilov@gmail.com"
system := `nix eval --raw --impure --expr builtins.currentSystem`
nix_user_env := "USERNAME=" + username + " GIT_NAME=" + git_name + " GIT_EMAIL=" + git_email

# Apply configuration for the current system (backs up conflicting files)

# profile: full, dev, or minimal
apply profile:
    #!/usr/bin/env sh
    if echo "{{ system }}" | grep -q darwin; then
        {{ nix_user_env }} sudo nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- switch --impure --flake ".#{{ username }}-{{ profile }}@{{ system }}"
    else
        {{ nix_user_env }} nix run github:nix-community/home-manager -- switch --impure --flake ".#{{ username }}-{{ profile }}@{{ system }}" -b backup
    fi

# Set up GPU drivers for Nix on non-NixOS Linux (run after apply if GPU-accelerated apps break)
gpu-setup:
    sudo $(find /nix/store -maxdepth 3 -name "non-nixos-gpu-setup" 2>/dev/null | head -1)

# Show Home Manager news for the current system

# profile: full, dev, or minimal
news profile:
    {{ nix_user_env }} home-manager news --impure --flake ".#{{ username }}-{{ profile }}@{{ system }}"

# Format Nix files. mode: check (default) or fix
nix-fmt mode="check":
    find . -name '*.nix' -not -path './.git/*' | xargs -r nix run nixpkgs#nixfmt -- {{ if mode == "fix" { "" } else { "--check" } }}

# Lint Nix files for antipatterns. mode: check (default) or fix
nix-lint mode="check":
    nix run nixpkgs#statix -- {{ if mode == "fix" { "fix" } else { "check" } }} .

# Find dead Nix code. mode: check (default) or fix
nix-dead mode="check":
    nix run nixpkgs#deadnix -- {{ if mode == "fix" { "--edit" } else { "--fail" } }} .

# Update all flake inputs
nix-update:
    nix flake update

# Validate flake structure
nix-check:
    {{ nix_user_env }} nix flake check --impure

# Build configuration for the current system without applying

# profile: full, dev, or minimal
nix-build profile:
    #!/usr/bin/env sh
    if echo "{{ system }}" | grep -q darwin; then
        {{ nix_user_env }} nix build --impure ".#darwinConfigurations.\"{{ username }}-{{ profile }}@{{ system }}\".system"
    else
        {{ nix_user_env }} nix build --impure ".#packages.{{ system }}.{{ username }}-{{ profile }}"
    fi

# Run a nix-shell with the Home Manager configuration for the current system
nix-shell:
    nix shell ./result/home-path

# Install git hooks
setup-hooks:
    printf '#!/bin/sh\njust lint\n' > .git/hooks/pre-push
    chmod +x .git/hooks/pre-push

# Run all linters (requires Docker for lint-base)
lint: nix-fmt nix-check nix-dead nix-lint lint-base

# Run Nix linters only (no Docker required, works on all platforms)
nix-lint-all: nix-fmt nix-dead nix-lint

# Build and run a fresh Docker container to test the Home Manager configuration from scratch
docker-test:
    docker build --file test.dockerfile --tag dotfiles-test .
    docker run --rm --interactive --tty dotfiles-test
