{
  username,
  gitName,
  gitEmail,
  shellName ? "fish",
  pkgs,
  ...
}:
{
  imports = [ ./fonts.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username gitName gitEmail; };
    sharedModules = [ ./packages.nix ];
  };

  # Must match custom.shell.name set in the HM profile.
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.${shellName};
  };

  system.primaryUser = username;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
