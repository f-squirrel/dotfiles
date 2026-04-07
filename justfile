import 'repo-setup/justfile'

username := env_var('USER')
git_name := "f-squirrel"
git_email := "dmitry.b.danilov@gmail.com"
system := `nix eval --raw --impure --expr builtins.currentSystem`
nix_user_env := "USERNAME=" + username + " GIT_NAME=" + git_name + " GIT_EMAIL=" + git_email

# Apply Home Manager configuration for the current system (backs up conflicting files)

# profile: full, dev, or minimal
apply profile:
    {{ nix_user_env }} nix run github:nix-community/home-manager -- switch --impure --flake ".#{{ username }}-{{ profile }}@{{ system }}" -b backup

# Set up GPU drivers for Nix on non-NixOS Linux (run after apply if GPU-accelerated apps break)
gpu-setup:
    sudo $(find /nix/store -maxdepth 3 -name "non-nixos-gpu-setup" 2>/dev/null | head -1)

# Show Home Manager news for the current system

# profile: full, dev, or minimal
news profile:
    {{ nix_user_env }} home-manager news --impure --flake ".#{{ username }}-{{ profile }}@{{ system }}"

# Update all flake inputs
nix-update:
    nix flake update

# Validate flake structure
nix-check:
    {{ nix_user_env }} nix flake check --impure

# Build Home Manager configuration for the current system without applying

# profile: full, dev, or minimal
nix-build profile:
    {{ nix_user_env }} nix build --impure ".#packages.{{ system }}.{{ username }}-{{ profile }}"

# Run a nix-shell with the Home Manager configuration for the current system
nix-shell:
    nix shell ./result/home-path

# Build and run a fresh Docker container to test the Home Manager configuration from scratch
docker-test:
    docker build --file Dockerfile.test --tag dotfiles-test .
    docker run --rm --interactive --tty dotfiles-test
