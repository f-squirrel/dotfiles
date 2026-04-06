{
  username,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

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
