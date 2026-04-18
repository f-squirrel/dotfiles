_: {
  programs.fzf = {
    enable = true;
    fileWidgetOptions = [
      "--preview 'bat --color=always --line-range :200 {}'"
    ];
  };
}
