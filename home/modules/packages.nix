{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    curl
    fd
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
