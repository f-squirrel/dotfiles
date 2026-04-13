{ lib, ... }:
let
  xdgConfigHome =
    let
      v = builtins.getEnv "XDG_CONFIG_HOME";
    in
    if v != "" then v else "${builtins.getEnv "HOME"}/.config";
  localExtraKdl = "${xdgConfigHome}/zellij/local-extra.kdl";
in
{
  imports = [
    ../../modules/shared/base.nix
    ../../modules/shared/atuin.nix
    ../../modules/shared/btop.nix
    ../../modules/shared/eza.nix
    ../../modules/shared/fzf.nix
    ../../modules/shared/git.nix
    ../../modules/shared/neovim.nix
    ../../modules/shared/packages-cli.nix
    ../../modules/shared/ripgrep.nix
    ../../modules/shared/zellij.nix
    ../../modules/shared/zoxide.nix
    ../../modules/shared/shell.nix
  ];

  custom.zellij = {
    theme = lib.mkDefault "nightfox";
    simplifiedUi = lib.mkDefault true;
    extraKeybindsFiles = lib.optional (builtins.pathExists localExtraKdl) localExtraKdl;
  };
}
