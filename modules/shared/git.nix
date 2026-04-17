{
  pkgs,
  gitName,
  gitEmail,
  ...
}:
{
  programs.git = {
    enable = true;
    signing.format = "openpgp";

    settings = {
      user = {
        name = gitName;
        email = gitEmail;
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
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      syntax-theme = "Dracula";
      paging = "always";
      pager = "less -R -+F";
      side-by-side = true;
      true-color = "always";
    };
  };

  home.packages = [ pkgs.delta ];
}
