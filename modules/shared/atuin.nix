_: {
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      auto_sync = false;
      search_mode = "prefix";
      filter_mode = "global";
      style = "compact";
      inline_height = 20;
    };
  };
}
