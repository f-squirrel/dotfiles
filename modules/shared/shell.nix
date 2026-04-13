{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell;
  isFish = cfg.name == "fish";
in
{
  imports = [
    ./fish.nix
    ./zsh.nix
    ./starship.nix
  ];

  options.custom.shell = {
    name = lib.mkOption {
      type = lib.types.enum [
        "fish"
        "zsh"
      ];
      default = "fish";
      description = "Which interactive shell to use.";
    };
    package = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      default = if isFish then pkgs.fish else pkgs.zsh;
      description = "The shell package (derived from custom.shell.name).";
    };
  };

  config.programs = {
    starship.enable = isFish;
    eza = {
      enableFishIntegration = isFish;
      enableZshIntegration = !isFish;
    };
    fzf = {
      enableFishIntegration = isFish;
      enableZshIntegration = !isFish;
    };
    zoxide = {
      enableFishIntegration = isFish;
      enableZshIntegration = !isFish;
    };
    atuin = {
      enableFishIntegration = isFish;
      enableZshIntegration = !isFish;
    };
  };
}
