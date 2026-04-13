{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      tokei = "tokei --hidden";
    };
    plugins = [
      {
        name = "git";
        inherit (pkgs.fishPlugins.plugin-git) src;
      }
    ];
    interactiveShellInit = ''
      ${builtins.readFile ../../scripts/worktree.fish}

      if test -f ~/.config/fish/local.fish
        source ~/.config/fish/local.fish
      end

      just --completions fish | source

      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx PIP_REQUIRE_VIRTUALENV true
    '';
  };
}
