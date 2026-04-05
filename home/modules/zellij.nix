{ pkgs, ... }: {
  programs.zellij.enable = true;

  xdg.configFile = {
    "zellij/config.kdl".source = ./zellij/config.kdl;
    "zellij/layouts/default.kdl".source = ./zellij/layouts/default.kdl;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "vscode-open" (builtins.readFile ../../scripts/utils/vscode-open.sh))
  ];
}
