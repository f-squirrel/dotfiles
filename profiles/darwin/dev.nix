{ username, ... }:
{
  imports = [ ../../modules/darwin/base.nix ];

  home-manager.users.${username} = import ../shared/dev.nix;
}
