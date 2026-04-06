import 'repo-setup/justfile'

username := "dima"
system   := `nix eval --raw --impure --expr builtins.currentSystem`

# Apply Home Manager configuration for the current system (backs up conflicting files)
# profile: full or minimal
apply profile:
    nix run github:nix-community/home-manager -- switch --flake ".#{{ username }}-{{ profile }}@{{ system }}" -b backup

# Set up GPU drivers for Nix on non-NixOS Linux (run after apply if GPU-accelerated apps break)
gpu-setup:
    sudo $(find /nix/store -maxdepth 3 -name "non-nixos-gpu-setup" 2>/dev/null | head -1)

# Show Home Manager news for the current system
# profile: full or minimal
news profile:
    home-manager news --flake ".#{{ username }}-{{ profile }}@{{ system }}"

# Update all flake inputs
nix-update:
    nix flake update

# Validate flake structure
nix-check:
    nix flake check

# Build Home Manager configuration for the current system without applying
# profile: full or minimal
nix-build profile:
    nix build ".#packages.{{ system }}.{{ username }}-{{ profile }}"

# Run a nix-shell with the Home Manager configuration for the current system
nix-shell:
    nix shell ./result/home-path

# Build and run a fresh Docker container to test the Home Manager configuration from scratch
docker-test:
    docker build --file Dockerfile.test --tag dotfiles-test .
    docker run --rm --interactive --tty dotfiles-test
