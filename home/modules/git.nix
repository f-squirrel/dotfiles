_: {
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
    };
  };
}
