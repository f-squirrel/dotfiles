{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    devcontainer
    duf
    dust
    fd
    glow
    gnumake
    jq
    just
    shellcheck
    tokei
    vale
    wget
  ];
}
