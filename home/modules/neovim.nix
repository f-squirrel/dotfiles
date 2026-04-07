{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    # Use extraLuaConfig so home-manager generates a single init.lua,
    # avoiding the init.vim vs init.lua conflict it would otherwise cause.
    extraLuaConfig = builtins.readFile ../config/nvim/init.lua;
  };

  # Build-time deps for lazy.nvim plugins:
  #   telescope-fzf-native + LuaSnip → need make (C compiler comes from stdenv or clang)
  home.packages = with pkgs; [
    gnumake
  ];

  home.shellAliases = {
    view = "nvim -R";
  };
}
