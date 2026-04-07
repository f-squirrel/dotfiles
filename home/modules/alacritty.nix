{ pkgs, ... }:
{
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];

  programs.alacritty.enable = true;

  xdg.configFile."alacritty".source = ../config/alacritty;

}
