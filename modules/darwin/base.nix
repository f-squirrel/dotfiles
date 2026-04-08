{
  username,
  gitName,
  gitEmail,
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

  users.users.${username}.home = "/Users/${username}";

  system.primaryUser = username;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
