{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    curl
    fd
    glow
    jq
    just
    gnumake
    wget
    btop
    keepassxc
    neovim
    python3
    python3Packages.ipython
    python3Packages.virtualenv
    du-dust
    shellcheck
    tokei
    vale
    claude-code
    devcontainer
  ];
}
