{
  username,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./modules/alacritty.nix
    ./modules/rust.nix
    ./modules/eza.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/packages.nix
    ./modules/packages-darwin.nix
    ./modules/ripgrep.nix
    ./modules/zellij.nix
    ./modules/starship.nix
    ./modules/atuin.nix
    ./modules/zsh.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
    ];

  home = {
    inherit username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

    # Do not change this when upgrading Home Manager.
    # See https://home-manager.nix.community/options.html#opt-home.stateVersion
    stateVersion = "24.11";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
}
