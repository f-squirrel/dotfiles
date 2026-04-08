{ username, ... }:
{
  imports = [
    ../../modules/darwin/base.nix
    ../../modules/darwin/homebrew.nix
  ];

  home-manager.users.${username} = import ../shared/dev.nix;
}
