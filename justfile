import 'repo-setup/justfile'

username := "dima"

# Apply Home Manager configuration for the current system
apply:
    #!/usr/bin/env sh
    arch=$(uname --machine)
    os=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
    [ "$arch" = "arm64" ] && arch="aarch64"
    home-manager switch --flake ".#{{ username }}@${arch}-${os}"

# Update all flake inputs
nix-update:
    nix flake update

# Validate flake structure
nix-check:
    nix flake check

# Build Home Manager configuration for the current system without applying
nix-build:
    #!/usr/bin/env sh
    arch=$(uname --machine)
    os=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
    [ "$arch" = "arm64" ] && arch="aarch64"
    nix build ".#homeConfigurations.{{ username }}@${arch}-${os}.activationPackage" --print-out-paths

# Run a nix-shell with the Home Manager configuration for the current system
nix-shell:
    nix shell ./result/home-path
