{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
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
    keepassxc
    python3
    python3Packages.ipython
    python3Packages.virtualenv
    shellcheck
    tokei
    vale
    wget
  ];
}
