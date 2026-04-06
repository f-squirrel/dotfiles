{ pkgs, ... }:
{
  imports = [
    ./minimal.nix
    ../modules/alacritty.nix
    ../modules/dropbox.nix
    ../modules/packages-cpp.nix
    ../modules/packages-gui.nix
    ../modules/packages-python.nix
    ../modules/rust.nix
  ];

  home.packages = [ pkgs.claude-code ];
}
