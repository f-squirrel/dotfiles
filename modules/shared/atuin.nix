_: {
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "1h";
      search_mode = "prefix";
      filter_mode = "global";
      style = "compact";
      inline_height = 20;
      ai.enabled = true;
    };
  };
}
