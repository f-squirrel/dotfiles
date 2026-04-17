{ config, pkgs, ... }:
{
  config = {
    programs.fish = {
      enable = config.custom.shell.name == "fish";
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
        # Source nix daemon — fish does not read /etc/profile
        if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
          source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        end

        ${builtins.readFile ../../scripts/worktree.fish}

        if test -f ~/.config/fish/local.fish
          source ~/.config/fish/local.fish
        end

        just --completions fish | source

        set -gx EDITOR nvim
        set -gx VISUAL nvim
        set -gx PIP_REQUIRE_VIRTUALENV true

        # Rebind fzf file search from Ctrl+t to Ctrl+f
        bind \cf fzf-file-widget
        bind -e \ct
      '';
    };
  };
}
