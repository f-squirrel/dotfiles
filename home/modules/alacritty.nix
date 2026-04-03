{ pkgs, ... }:
let
  esc = builtins.fromJSON ''"\u001B"'';
  dc1 = builtins.fromJSON ''"\u0011"'';
  cr = builtins.fromJSON ''"\r"'';
in
{
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  programs.alacritty = {
    enable = true;

    settings = {
      general.live_config_reload = true;

      font = {
        size = 12.0;
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
        bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
        italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
      };

      colors = {
        primary = {
          background = "0x1e2127";
          foreground = "0xabb2bf";
        };
        normal = {
          black = "0x1e2127";
          red = "0xe06c75";
          green = "0x98c379";
          yellow = "0xd19a66";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x56b6c2";
          white = "0xabb2bf";
        };
        bright = {
          black = "0x5c6370";
          red = "0xe06c75";
          green = "0x98c379";
          yellow = "0xd19a66";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x56b6c2";
          white = "0xffffff";
        };
      };

      keyboard.bindings = [
        { key = "Q"; mods = "Control"; chars = dc1; }
        { key = "B"; mods = "Alt"; chars = "${esc}b"; }
        { key = "B"; mods = "Alt|Shift"; chars = "${esc}B"; }
        { key = "F"; mods = "Alt"; chars = "${esc}f"; }
        { key = "F"; mods = "Alt|Shift"; chars = "${esc}F"; }
        { key = "F11"; mods = "None"; action = "ToggleFullscreen"; }
        { key = "Return"; mods = "Shift"; chars = "${esc}${cr}"; }
      ];

      terminal.shell.program = "zsh";

      window = {
        dynamic_title = true;
        startup_mode = "Maximized";
      };
    };
  };
}
