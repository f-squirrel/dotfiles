{ pkgs, lib, ... }:
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
    openconnect
    shellcheck
    tokei
    vale
    wget
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    xsel
  ];
}
