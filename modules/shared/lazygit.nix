{ catppuccin-lazygit, pkgs, ... }:
{
  home.packages = [ pkgs.lazygit ];

  xdg.configFile."lazygit/config.yml".source =
    "${catppuccin-lazygit}/themes-mergable/mocha/green.yml";
}
