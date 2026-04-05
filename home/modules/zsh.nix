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
      theme = "";
    };
    initContent = ''
      [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
      source <(just --completions zsh)
      export PIP_REQUIRE_VIRTUALENV=true

      # Print a blank line before each prompt except the first one in a session
      _first_prompt=1
      _starship_newline_precmd() {
        if [[ -n $_first_prompt ]]; then
          unset _first_prompt
        else
          echo
        fi
      }
      precmd_functions+=(_starship_newline_precmd)

      # Let atuin own ctrl+r instead of fzf
      bindkey '^R' atuin-search
    '';
  };
}
