{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    duf
    gh
    dust
    fd
    glow
    gnumake
    jq
    just
    sd
    shellcheck
    wget
  ];
}
