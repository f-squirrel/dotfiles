{ pkgs, lib, ... }:
{
  services.dropbox.enable = lib.mkIf pkgs.stdenv.isLinux true;
}
