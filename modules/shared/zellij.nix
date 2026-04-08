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
  };

  config = {
    programs.zellij.enable = true;

    # Copy layout assets, then render the main config with profile-specific substitutions.
    xdg.configFile."zellij/layouts".source = ../../config/zellij/layouts;
    xdg.configFile."zellij/config.kdl".source = pkgs.replaceVars ../../config/zellij/config.kdl.in {
      zellijTheme = cfg.theme;
      simplifiedUi = if cfg.simplifiedUi then "true" else "false";
    };

    home.packages = [
      (pkgs.writeShellScriptBin "open-ide" (builtins.readFile ../../scripts/open-ide.sh))
    ];
  };
}
