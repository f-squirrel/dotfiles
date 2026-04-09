_: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "solarized_dark";
      shown_boxes = "cpu mem net proc";
    };
  };
}
