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
    extraKeybindsFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Paths to KDL files whose contents are injected inside the keybinds block. Read at eval time, so files must exist when building.";
    };
  };

  config = {
    programs.zellij.enable = true;

    # Copy layout assets, theme files, then render the main config with profile-specific substitutions.
    xdg.configFile = {
      "zellij/layouts".source = ../../config/zellij/layouts;
      "zellij/themes".source = ../../config/zellij/themes;
      "zellij/config.kdl".text =
        lib.replaceStrings
          [
            "@zellijTheme@"
            "@simplifiedUi@"
            "@extraKeybinds@"
          ]
          [
            cfg.theme
            (if cfg.simplifiedUi then "true" else "false")
            (lib.concatMapStrings (f: builtins.readFile f) cfg.extraKeybindsFiles)
          ]
          (builtins.readFile ../../config/zellij/config.kdl.in);
    };

    home.packages = [
      (pkgs.writeShellScriptBin "open-ide" (builtins.readFile ../../scripts/open-ide.sh))
    ];
  };
}
