{ pkgs, ... }:
{
  programs.zellij.enable = true;

  xdg.configFile."zellij".source = ../config/zellij;

  home.packages = [
    (pkgs.writeShellScriptBin "vscode-open" (builtins.readFile ../scripts/vscode-open.sh))
  ];
}
