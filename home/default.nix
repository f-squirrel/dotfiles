{ username, pkgs, ... }:
{
  imports = [
    ./modules/git.nix
    ./modules/packages.nix
    ./modules/zsh.nix
  ];

  home = {
    inherit username;
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${username}"
      else "/home/${username}";

    # Do not change this when upgrading Home Manager.
    # See https://home-manager.nix.community/options.html#opt-home.stateVersion
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
