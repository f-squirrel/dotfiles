_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [
      "brave-browser"
      "dropbox"
      "keepassxc"
      "telegram"
      "zoom"
    ];
  };
}
