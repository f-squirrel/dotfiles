{ config, lib, ... }:
{
  programs.alacritty.enable = true;

  xdg.configFile."alacritty/alacritty.toml".text =
    lib.replaceStrings [ "@defaultShell@" ] [ config.custom.shell.name ]
      (builtins.readFile ../../config/alacritty/alacritty.toml);
}
