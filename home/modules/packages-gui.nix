{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    keepassxc
    telegram-desktop
  ];
}
