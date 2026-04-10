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
    if ! /usr/bin/grep -qF "${pkgs.zsh}/bin/zsh" /etc/shells; then
      echo "${pkgs.zsh}/bin/zsh" | /usr/bin/sudo /usr/bin/tee -a /etc/shells > /dev/null
    fi
    if [ "$(/usr/bin/getent passwd ${username} | cut -d: -f7)" != "${pkgs.zsh}/bin/zsh" ]; then
      run /usr/bin/chsh -s ${pkgs.zsh}/bin/zsh ${username}
    fi
  '';
}
