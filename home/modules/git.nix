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
        lg = "log --color --graph --pretty=format:'%C(yellow)%h%Creset -%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit --format=format:'%C(yellow)%h%C(reset)%d%C(reset) %s%C(reset) %C(green)(%ar)%C(reset) %C(bold blue)<%an>%C(reset)'";
        lola = "!git lol --all";
        lgc = "!git lg | sed '$a\\\\' | grep '* ' | tac | cat -n | sed 's/^[ \\t]*//' | sed 's/[\\t]*[\\\\*]//' | tac | less";
        st = "status";
        patch = "am --signoff --ignore-space-change --ignore-whitespace";
        info = "rev-list HEAD --count";
        up = "!STASHED=$( git stash | wc -l ) && git pull --rebase && test $STASHED -gt 1 && git stash pop || true";
        ls = "ls-files";
        unstage = "reset HEAD";
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
