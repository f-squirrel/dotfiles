_: {
  programs.git = {
    enable = true;
    userName = "f-squirrel";
    userEmail = "dmitry.b.danilov@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}
