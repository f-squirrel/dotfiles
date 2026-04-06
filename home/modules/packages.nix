{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    clang
    clang-tools
    claude-code
    cmake
    curl
    devcontainer
    duf
    dust
    fd
    glow
    gnumake
    ninja
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
