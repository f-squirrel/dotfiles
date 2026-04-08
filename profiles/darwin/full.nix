{ username, ... }:
{
  imports = [
    ../../modules/darwin/base.nix
    ../../modules/darwin/homebrew.nix
  ];

  home-manager.users.${username} = import ../../profiles/linux/full.nix;
}
