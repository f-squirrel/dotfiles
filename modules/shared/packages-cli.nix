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
    lumen
    mdcat
    sd
    shellcheck
    wget
  ];
}
