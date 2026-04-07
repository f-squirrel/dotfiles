{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;

  # tree-sitter CLI is required by nvim-treesitter (main branch) to compile parsers
  home.packages = [ pkgs.tree-sitter ];

  home.shellAliases = {
    view = "nvim -R";
  };
}
