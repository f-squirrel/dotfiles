{ ... }:
{
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/config.kdl".source = ./zellij/config.kdl;
    "zellij/layouts/default.kdl".source = ./zellij/layouts/default.kdl;
  };

  home.file = {
    ".local/bin/vscode-open.sh" = {
      source = ../../scripts/utils/vscode-open.sh;
      executable = true;
    };
  };
}
