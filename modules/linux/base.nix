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
    if ! /usr/bin/grep -qF "${pkgs.fish}/bin/fish" /etc/shells; then
      echo "${pkgs.fish}/bin/fish" | /usr/bin/sudo /usr/bin/tee -a /etc/shells > /dev/null
    fi
    if [ "$(/usr/bin/getent passwd ${username} | cut -d: -f7)" != "${pkgs.fish}/bin/fish" ]; then
      run /usr/bin/chsh -s ${pkgs.fish}/bin/fish ${username}
    fi
  '';
}
