{ pkgs, ... }:
{
  imports = [
    ./minimal.nix
    ../modules/dropbox.nix
    ../modules/packages-cpp.nix
    ../modules/packages-gui.nix
    ../modules/rust.nix
  ];

  home.packages = [ pkgs.claude-code ];
}
