_: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      cmd_duration = {
        min_time = 0;
        format = "took [$duration]($style) ";
      };

      time = {
        disabled = false;
        format = "at [$time]($style) ";
        time_format = "%T";
      };
    };
  };
}
