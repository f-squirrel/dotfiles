_: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      format = "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala$swift$terraform$typst$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$nats$direnv$env_var$crystal$custom$sudo$cmd_duration$time$line_break$jobs$battery$status$container$os$shell$character";

      cmd_duration = {
        min_time = 0;
        format = "took [$duration]($style) ";
      };

      time = {
        disabled = false;
        format = "at [$time]($style) ";
        time_format = "%Y-%m-%d %T";
      };
    };
  };
}
