{ pkgs, ... }:
{
  home.packages = with pkgs; [
    claude-code
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
