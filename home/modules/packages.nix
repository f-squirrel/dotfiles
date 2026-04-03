{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    curl
    fd
    jq
    just
    ripgrep
    wget
    zellij
    btop
    keepassxc
    neovim
  ];
}
