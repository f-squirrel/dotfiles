{ username, ... }:
{
  imports = [
    ../modules/base.nix
    ../modules/homebrew.nix
  ];

  home-manager.users.${username} = import ../../home/profiles/full.nix;
}
