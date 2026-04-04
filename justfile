import 'repo-setup/justfile'

username := "dima"

# Apply Home Manager configuration for the current system (backs up conflicting files)
apply:
    nix run github:nix-community/home-manager -- switch --flake ".#dima@$(nix eval --raw --impure --expr builtins.currentSystem)" -b backup

# Update all flake inputs
nix-update:
    nix flake update

# Validate flake structure
nix-check:
    nix flake check

# Build Home Manager configuration for the current system without applying
nix-build:
    nix build ".#packages.$(nix eval --raw --impure --expr builtins.currentSystem).activation"

# Run a nix-shell with the Home Manager configuration for the current system
nix-shell:
    nix shell ./result/home-path

# Build and run a fresh Docker container to test the Home Manager configuration from scratch
docker-test:
    docker build --file Dockerfile.test --tag dotfiles-test .
    docker run --rm --interactive --tty dotfiles-test
