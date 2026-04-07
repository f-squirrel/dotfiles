{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    # Use extraLuaConfig so home-manager generates a single init.lua,
    # avoiding the init.vim vs init.lua conflict it would otherwise cause.
    initLua = builtins.readFile ../config/nvim/init.lua;
  };

  # tree-sitter CLI is required by nvim-treesitter (main branch) to compile parsers
  home.packages = [ pkgs.tree-sitter ];

  home.shellAliases = {
    view = "nvim -R";
  };
}
