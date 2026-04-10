{
  username,
  pkgs,
  lib,
  ...
}:
{
  home.homeDirectory = "/home/${username}";
  targets.genericLinux.enable = true;

  home.activation.setDefaultShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ "$(getent passwd ${username} | cut -d: -f7)" != "${pkgs.zsh}/bin/zsh" ]; then
      run chsh -s ${pkgs.zsh}/bin/zsh ${username}
    fi
  '';
}
