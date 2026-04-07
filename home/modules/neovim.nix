{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

  # kickstart.nvim config — lazy.nvim manages plugins at runtime
  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;

  # Build-time deps for lazy.nvim plugins:
  #   telescope-fzf-native  → needs make + gcc
  #   LuaSnip               → needs make (jsregexp build step)
  home.packages = with pkgs; [
    gcc
    gnumake
  ];

  home.shellAliases = {
    view = "nvim -R";
  };
}
