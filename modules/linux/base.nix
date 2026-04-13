{
  username,
  config,
  lib,
  ...
}:
let
  shell = config.custom.shell.package;
  shellBin = "${shell}/bin/${config.custom.shell.name}";
in
{
  home.homeDirectory = "/home/${username}";
  targets.genericLinux.enable = true;

  home.activation.setDefaultShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! /usr/bin/grep -qF "${shellBin}" /etc/shells; then
      echo "${shellBin}" | /usr/bin/sudo /usr/bin/tee -a /etc/shells > /dev/null
    fi
    if [ "$(/usr/bin/getent passwd ${username} | cut -d: -f7)" != "${shellBin}" ]; then
      run /usr/bin/chsh -s ${shellBin} ${username}
    fi
  '';
}
