{ pkgs, ... }:
{
  imports = [
    ./minimal.nix
    ../modules/packages-cpp.nix
    ../modules/packages-python.nix
    ../modules/rust.nix
  ];

  home.packages = with pkgs; [
    claude-code
    devcontainer
    openconnect
    tokei
    vale
    vscode
  ];
}
