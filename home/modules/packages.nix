{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    curl
    fd
    glow
    jq
    just
    wget
    btop
    keepassxc
    neovim
    python3
    python3Packages.ipython
    python3Packages.virtualenv
  ];
}
