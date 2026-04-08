{ username, ... }:
{
  imports = [ ../../modules/darwin/base.nix ];

  home-manager.users.${username} = import ../../profiles/linux/minimal.nix;
}
