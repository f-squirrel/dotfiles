{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    duf
    dust
    fd
    glow
    gnumake
    jq
    just
    shellcheck
    wget
  ];
}
