{ pkgs, ... }:
{
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "JetBrainsMono Nerd Font Mono" ];
  };
}
