_: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        # Catppuccin Mocha Green — source: ${catppuccin-lazygit}/themes-mergable/mocha/green.yml
        theme = {
          activeBorderColor = [
            "#a6e3a1"
            "bold"
          ];
          inactiveBorderColor = [ "#a6adc8" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          inactiveViewSelectedLineBgColor = [ "#6c7086" ];
          cherryPickedCommitFgColor = [ "#a6e3a1" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          markedBaseCommitFgColor = [ "#89b4fa" ];
          markedBaseCommitBgColor = [ "#f9e2af" ];
          unstagedChangesColor = [ "#f38ba8" ];
          defaultFgColor = [ "#cdd6f4" ];
        };
        authorColors."*" = "#b4befe";
        timeFormat = "02 Jan 06 15:04";
        shortTimeFormat = "02 Jan 06 15:04";
      };
    };
  };
}
