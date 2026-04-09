{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    keepassxc
    telegram-desktop
    (zoom-us.override {
      targetPkgs = _pkgs: [ gnome-settings-daemon ];
    })
  ];
}
