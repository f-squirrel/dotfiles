{ pkgs, ... }:
{
  programs.zellij.enable = true;

  xdg.configFile."zellij".source = ../config/zellij;

  home.packages = [
    (pkgs.writeShellScriptBin "open-ide" (builtins.readFile ../scripts/open-ide.sh))
  ];
}
