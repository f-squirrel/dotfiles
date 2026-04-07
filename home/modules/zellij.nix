{ pkgs, ... }:
{
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/config.kdl".source = ../config/zellij/config.kdl;
    "zellij/layouts/default.kdl".source = ../config/zellij/layouts/default.kdl;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "vscode-open" (builtins.readFile ../../scripts/utils/vscode-open.sh))
  ];
}
