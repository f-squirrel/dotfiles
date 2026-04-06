{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    signing.format = "openpgp";

    settings = {
      user = {
        name = "f-squirrel";
        email = "dmitry.b.danilov@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      merge = {
        conflictstyle = "diff3";
        tool = "vimdiff3";
      };
      mergetool = {
        prompt = false;
        "vimdiff3".cmd = ''nvim -f -c "Gdiffsplit!" "$MERGED"'';
      };
      diff = {
        colorMoved = "default";
        tool = "default-difftool";
      };
      difftool."default-difftool".cmd = "code --wait --diff $LOCAL $REMOTE";
      alias = {
        lgc = "!git glol | sed '$a\\\\' | grep '* ' | tac | cat -n | sed 's/^[ \\t]*//' | sed 's/[\\t]*[\\\\*]//' | tac | less";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      syntax-theme = "Dracula";
      paging = "always";
      side-by-side = true;
      true-color = "always";
    };
  };

  home.packages = [ pkgs.delta ];
}
