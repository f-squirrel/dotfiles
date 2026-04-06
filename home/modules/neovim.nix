{ ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

  home.shellAliases = {
    view = "nvim -R";
  };
}
