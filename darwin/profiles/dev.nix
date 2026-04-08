{ username, ... }:
{
  imports = [ ../modules/base.nix ];

  home-manager.users.${username} = import ../../home/profiles/dev.nix;
}
