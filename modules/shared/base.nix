{ username, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    inherit username;
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
