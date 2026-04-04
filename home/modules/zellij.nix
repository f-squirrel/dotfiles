{ pkgs, ... }:
{
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/config.kdl" = {
      source = ./zellij/config.kdl;
      force = true;
    };
    "zellij/layouts/default.kdl" = {
      source = ./zellij/layouts/default.kdl;
      force = true;
    };
  };

  home.file = {
    ".local/bin/vscode-open.sh" = {
      source = ../../scripts/utils/vscode-open.sh;
      executable = true;
    };
  };
}
