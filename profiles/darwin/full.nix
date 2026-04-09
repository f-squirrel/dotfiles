{ ... }:
{
  imports = [
    ./dev.nix
    ../../modules/shared/nix-index.nix
    ../../modules/darwin/homebrew.nix
  ];
}
