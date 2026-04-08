{ pkgs, ... }:
{
  imports = [
    ./minimal.nix
    ../../modules/shared/packages-cpp.nix
    ../../modules/shared/packages-python.nix
    ../../modules/shared/rust.nix
  ];

  home.packages = with pkgs; [
    claude-code
    devcontainer
    openconnect
    tokei
    vale
    vscode
  ];

  custom.zellij = {
    theme = "nightfox";
    simplifiedUi = false;
  };
}
