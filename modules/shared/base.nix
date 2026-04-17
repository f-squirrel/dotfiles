{ username, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    inherit username;
    stateVersion = "26.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  programs.home-manager.enable = true;
}
