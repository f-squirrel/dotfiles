{ pkgs, ... }:
{
  home.packages = [ pkgs.ghostty ];

  xdg.configFile."ghostty/config".source = ../../config/ghostty/config;

  # Override the upstream .desktop to disable DBusActivatable, which fails
  # under Nix because the corresponding systemd service is not installed.
  xdg.dataFile."applications/com.mitchellh.ghostty.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Name=Ghostty
    Type=Application
    Comment=A terminal emulator
    Exec=${pkgs.ghostty}/bin/ghostty --gtk-single-instance=true
    Icon=com.mitchellh.ghostty
    Categories=System;TerminalEmulator;
    Keywords=terminal;tty;pty;
    StartupNotify=true
    StartupWMClass=com.mitchellh.ghostty
    Terminal=false
    DBusActivatable=false
  '';
}
