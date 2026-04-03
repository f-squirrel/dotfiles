{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    curl
    fd
    jq
    just
    wget
    zellij
    btop
    keepassxc
    neovim
  ];
}
