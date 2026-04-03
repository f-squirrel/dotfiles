{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    fd
    jq
    just
    ripgrep
    wget
    zellij
    keepassxc
  ];
}
