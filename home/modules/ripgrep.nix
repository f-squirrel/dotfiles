_: {
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--glob=!.git/*"
      "--smart-case"
      "--with-filename"
      "--no-heading"
      "--hidden"
    ];
  };
}
