{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.zellij;
in
{
  options.custom.zellij = {
    theme = lib.mkOption {
      type = lib.types.str;
      default = "nightfox";
      description = "Zellij theme name to use.";
    };
    simplifiedUi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Zellij simplified_ui.";
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra KDL config appended to the generated zellij config. Useful for machine-specific or private settings not tracked in the repo.";
    };
    extraConfigFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Paths to KDL files whose contents are appended to the generated zellij config. Read at eval time, so files must exist when building.";
    };
  };

  config = {
    programs.zellij.enable = true;

    # Copy layout assets, then render the main config with profile-specific substitutions.
    xdg.configFile."zellij/layouts".source = ../../config/zellij/layouts;
    xdg.configFile."zellij/config.kdl".text =
      (lib.replaceStrings
        [ "@zellijTheme@" "@simplifiedUi@" ]
        [
          cfg.theme
          (if cfg.simplifiedUi then "true" else "false")
        ]
        (builtins.readFile ../../config/zellij/config.kdl.in)
      )
      + lib.optionalString (cfg.extraConfig != "") "\n${cfg.extraConfig}"
      + lib.concatMapStrings (f: "\n${builtins.readFile f}") cfg.extraConfigFiles;

    home.packages = [
      (pkgs.writeShellScriptBin "open-ide" (builtins.readFile ../../scripts/open-ide.sh))
    ];
  };
}
