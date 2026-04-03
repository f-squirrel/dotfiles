_: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      share = true;
    };
    oh-my-zsh = {
      enable = true;
      theme = "miloshadzic";
    };
    initContent = ''
      source <(just --completions zsh)
      export PIP_REQUIRE_VIRTUALENV=true
    '';
  };
}
