{ lib, ... }:
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
    ../../modules/shared/starship.nix
    ../../modules/shared/zellij.nix
    ../../modules/shared/zoxide.nix
    ../../modules/shared/zsh.nix
  ];

  custom.zellij = {
    theme = lib.mkDefault "nightfox";
    simplifiedUi = lib.mkDefault true;
  };
}
