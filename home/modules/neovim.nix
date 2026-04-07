{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

  # kickstart.nvim config — lazy.nvim manages plugins at runtime
  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;

  # Build-time deps for lazy.nvim plugins:
  #   telescope-fzf-native + LuaSnip → need make (C compiler comes from stdenv or clang)
  home.packages = with pkgs; [
    gnumake
  ];

  home.shellAliases = {
    view = "nvim -R";
  };
}
