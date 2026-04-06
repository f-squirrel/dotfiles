{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    curl
    fd
    glow
    jq
    just
    gnumake
    wget
    keepassxc
    python3
    python3Packages.ipython
    python3Packages.virtualenv
    dust
    shellcheck
    tokei
    vale
    claude-code
    devcontainer
    duf
  ];
}
