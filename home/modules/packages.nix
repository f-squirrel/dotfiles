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
  ];
}
