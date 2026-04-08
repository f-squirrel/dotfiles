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
    sharedModules = [ ./packages-darwin.nix ];
  };

  users.users.${username}.home = "/Users/${username}";

  system.primaryUser = username;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
