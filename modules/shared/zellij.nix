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

    # Copy plugin/layout assets, then override config with profile-specific substitutions.
    xdg.configFile."zellij".source = ../../config/zellij;
    xdg.configFile."zellij/config.kdl".source = pkgs.replaceVars ../../config/zellij/config.kdl.in {
      zellijTheme = cfg.theme;
      simplifiedUi = if cfg.simplifiedUi then "true" else "false";
    };

    home.packages = [
      (pkgs.writeShellScriptBin "open-ide" (builtins.readFile ../../scripts/open-ide.sh))
    ];
  };
}
