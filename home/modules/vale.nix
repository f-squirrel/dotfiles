{ pkgs, ... }:
{
  programs.vale = {
    enable = true;
    settings = {
      core = {
        StylesPath = "styles";
        MinAlertLevel = "warning";
      };
    };
  };
}
