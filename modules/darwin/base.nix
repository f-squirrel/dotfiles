{
  username,
  gitName,
  gitEmail,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username gitName gitEmail; };
  };

  users.users.${username}.home = "/Users/${username}";

  system.primaryUser = username;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
