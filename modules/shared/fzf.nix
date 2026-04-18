_:
let
  ctrlTOpts = "--preview 'bat --color=always --line-range :200 {}'";
in
{
  programs = {
    fzf.enable = true;

    fish.interactiveShellInit = ''
      set -gx FZF_CTRL_T_OPTS "${ctrlTOpts}"
    '';

    zsh.initContent = ''
      export FZF_CTRL_T_OPTS="${ctrlTOpts}"
    '';
  };
}
